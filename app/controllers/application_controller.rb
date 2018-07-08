class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: %i(show index)
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  private

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_url)
  end

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

  def is_admin?
    return false unless user_signed_in?
    current_user.has_role? :admin
  end
end
