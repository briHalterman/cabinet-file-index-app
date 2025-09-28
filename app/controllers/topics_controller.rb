class TopicsController < ApplicationController
  def show
    @topic = Topic.find(params[:id])
    @decks = @topic.decks
  end

  def new
    @topic = Topic.new
    @categories = Category.all
  end

  def create
    @topic = Topic.new(topic_params)
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
    # @topic =
    @categories = Category.all
  end

  def update; end

  def destroy; end

  private

  def topic_params
    params.require(:topic).permit(:title, :category_id)
  end
end