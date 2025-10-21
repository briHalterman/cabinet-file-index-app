class TopicsController < ApplicationController
  before_action :require_user

  def show
    @current_user = User.find_by(id: session[:user_id])
    @topic = Topic.find_by(id: params[:id])

    if @topic.user_id != @current_user.id
      redirect_to root_path and return
    end

    @decks = @topic.decks
  end

  def new
    @current_user = User.find_by(id: session[:user_id])
    @topic = @current_user.topics.new
    @categories = Category.all
  end

  def create
    @current_user = User.find_by(id: session[:user_id])
    @topic = @current_user.topics.new(topic_params)
    @categories = Category.all

    respond_to do |format|
      if @topic.save
        format.html { redirect_to topic_path(@topic), notice: 'Topic was successfully created.' }
        format.json { render :show, status: :created, location: @topic }
      else
        format.html { render :new, status: :bad_request }
        format.json { render json: @topic.errors, status: :bad_request }
      end
    end
  end

  def edit
    @current_user = User.find_by(id: session[:user_id])
    @topic =  @current_user.topics.find(params[:id])

    if @topic.user_id != @current_user.id
      redirect_to root_path and return
    end

    @categories = Category.all
  end

  def update
    @current_user = User.find_by(id: session[:user_id])
    @topic = @current_user.topics.find(params[:id])

    if @topic.user_id != @current_user.id
      redirect_to root_path and return
    end

    @categories = Category.all

    respond_to do |format|
      if topic_params[:category_id].present? && @topic.update(topic_params)
        format.html { redirect_to @topic, notice: 'Topic was successfully updated.' }
        format.json { render :show, status: :ok, location: @topic }
      else
        format.html { render :edit, status: :bad_request }
        format.json { render json @topic.errors, status: :bad_request }
      end
    end
  end

  def destroy; end

  private

  def topic_params
    params.require(:topic).permit(:title, :category_id)
  end
end