class ApplicationController < ActionController::Base
  before_action :authenticate_user!, except: %i(show index)

  protected

  # Overwriting the sign_out redirect path method
  def after_sign_out_path_for(resource_or_scope)
    URI.parse(request.referer).path if request.referer
  end
end
