class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def require_user
    if session[:role] != 'user'
      flash[:alert] = 'You do not have access to that page'
        redirect_to login_path
        response.status = 403
      end
  end
end
