class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  allow_browser versions: :modern

  private

  def set_cat
    @cat = Cat.find(params[:cat_id] || params[:id])
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [ :username ])
    devise_parameter_sanitizer.permit(:account_update, keys: [ :username ])
  end
end
