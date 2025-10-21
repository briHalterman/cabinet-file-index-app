class DashboardController < ApplicationController
  before_action :require_user

  def index
    @current_user = User.find_by(id: session[:user_id])
    @categories = Category.all
    # @topics = Topic.where()
  end
end
