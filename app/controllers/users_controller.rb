class UsersController < ApplicationController
  def show; end

  def new
    @user = User.new
    @user.role = 'user'
  end

  def create
    @user = User.new(user_params)
    @user.role = 'user'

    respond_to do |format|
      if @user.save
        format.html { redirect_to login_path, notice: 'New user was successfully registered. Please log in.' }
        format.json { render :login, status: :created, location: login_path }
      else
        format.html { render :new, status: :bad_request }
        format.json { render json: @user.errors, status: :bad_request }
      end
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def user_params
    params.require(:user).permit(:username, :password, :role)
  end
end
