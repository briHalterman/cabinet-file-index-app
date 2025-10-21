class CategoriesController < ApplicationController
  before_action :require_user

  def index
    @categories = Category.all
  end

  def show
    @current_user = User.find_by(id: session[:user_id])
    @category = Category.find(params[:id])
    @topics = @category.topics
  end
end