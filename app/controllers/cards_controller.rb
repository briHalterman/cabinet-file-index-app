class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def show
    @deck = Deck.find(params[:deck_id])
    @card = @deck.cards.find(params[:id])

    if params[:side] == "face"
      @content = @card.face_content
    elsif params[:side] == "back"
      @content = @card.back_content
    end
  end

  def new; end

  def create; end

  def edit; end

  def update; end

  def destroy; end
end