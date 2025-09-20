class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def show
    @card = Card.find(params[:id])

    if params[:side] == "face"
      @content = @card.face_content
    elsif params[:side] == "back"
      @content = @card.back_content
    end
  end
end