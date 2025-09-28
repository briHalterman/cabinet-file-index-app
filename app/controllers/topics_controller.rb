class TopicsController < ApplicationController
  def show
    @topic = Topic.find(params[:id])
    @decks = @topic.decks
  end

  def new
    @topic = Topic.new
    @categories = Category.all
  end

  def create; end

  def edit; end

  def update; end

  def destroy; end
end