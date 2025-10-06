class DashboardController < ApplicationController
  before_action :require_user

  def index
    @categories = Category.all
  end
end
