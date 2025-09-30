class DecksController < ApplicationController
  def show
    @deck = Deck.find(params[:id])
    @cards = @deck.cards
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end
end