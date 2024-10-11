class ProfileImageUploader < CarrierWave::Uploader::Base
  storage :fog

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end

  def default_url(*args)
    ActionController::Base.helpers.asset_path("default_user_image.png")
  end

  def extension_allowlist
    %w[jpg jpeg gif png]
  end
end
