class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: %i(show index)
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    URI.parse(request.referer).path if request.referer
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:username, :email, :password, :password_confirmation)
    end
  end
end
