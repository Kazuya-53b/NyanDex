class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :set_user

  def show
  end

  def edit
  end

  def update_username
    if @user.update(user_params)
      flash.now[:notice] = "ユーザー名を更新しました"
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("user-info-container", partial: "users/edit_username", locals: { user: @user }),
            turbo_stream.replace("flash-message-container", partial: "layouts/flash_message")
          ]
        end
        format.html { redirect_to @user, notice: "ユーザー名を更新しました" }
      end
    else
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: turbo_stream.replace("user-info-container", partial: "users/edit_username", locals: { user: @user })
        end
        format.html { render :edit }
      end
    end
  end

  def update_profile_image
    if @user.update(user_params)
      flash.now[:notice] = "プロフィール画像を更新しました"
      respond_to do |format|
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace("user-profile-image", partial: "users/profile_image_form", locals: { user: @user }),
            turbo_stream.replace("flash-message-container", partial: "layouts/flash_message")
          ]
        end
        format.html { redirect_to @user, notice: "プロフィール画像を更新しました" }
      end
    else
      flash.now[:alert] = "画像の更新に失敗しました"
      render :show
    end
  end

  def mypage
    @cats = @user.cats
  end

  private

  def set_user
    @user = User.find(params[:id])

    if @user != current_user && action_name != "mypage"
      redirect_to root_path, alert: "アクセス権がありません"
    end
  end

  def user_params
    params.require(:user).permit(:username, :profile_image)
  end
end
