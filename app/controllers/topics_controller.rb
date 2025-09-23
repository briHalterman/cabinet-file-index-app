class TopicsController < ApplicationController
  def show
    @topic = Topic.find(params[:id])

    @decks = @topic.decks
  end
end