class UsersController < ApplicationController
  def show; end

  def new
    @user = User.new
    @user.role = 'user'
  end

  def create; end

  def edit; end

  def update; end

  def destroy; end

  private

  def user_params
    params.require(:user).permit(:username, :password, :role)
  end
end
