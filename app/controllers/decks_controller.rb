class DecksController < ApplicationController
  def show
    @deck = Deck.find(params[:id])
    @cards = @deck.cards
  end

  def new
    @deck = Deck.new
    @topics = Topic.all
  end

  def create; end

  def edit; end

  def update; end

  def destroy; end
end