class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  def require_user
    if session[:role] != 'user'
      flash[:alert] = 'You do not have access tot that page'
        redirect_do login_path
      end
  end
end
