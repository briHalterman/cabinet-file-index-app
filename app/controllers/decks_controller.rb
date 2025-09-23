class DecksController < ApplicationController
  def show
    @deck = Deck.find(params[:id])
    @cards = @deck.cards
  end
end