class CatsController < ApplicationController
  def index
    @cats = Cat.includes(:user).limit(20)
    respond_to do |format|
      format.html
      format.turbo_stream
    end
  end

  def new
    @cat = Cat.new
  end

  def show
    @cat = Cat.find(params[:id])
    @cat.images
  end

  def create
    @cat = Cat.new(cat_params)
    @cat.user_id = current_user.id if user_signed_in?

    if @cat.save
      redirect_to @cat, notice: "プロフィールを作成しました"
    else
      render :new
    end
  end

  private

  def cat_params
    params.require(:cat).permit(:name, :gender, :age, :breed, :color, :pattern, :short_description, :long_description, images: [])
  end

  def upload_images_to_s3(cat, crop_params)
    s3 = Aws::S3::Resource.new(region: ENV["AWS_REGION"])
    image_urls = []

    cat.images.each_with_index do |image, index|
      next if image.blank? || image.is_a?(String)

      begin
        # トリミング処理を追加
        uploader = ImageUploader.new
        uploader.store!(image)

        # 画像をトリミング
        uploader.crop_image(crop_params[index]) if crop_params[index].present?

        # S3にアップロード
        obj = s3.bucket("nyandexapp-images").object("cats/#{cat.id}/#{File.basename(image.tempfile)}")
        obj.upload_file(uploader.file.path)

        image_urls << obj.public_url
      rescue => e
        # エラーハンドリング（適宜）
      end
    end

    cat.update(images: image_urls) if image_urls.any?
  end
end
