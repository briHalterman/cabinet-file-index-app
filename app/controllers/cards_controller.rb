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

  def new
    @card = Card.new
    @decks = Deck.all
  end

  def create
    @card = Card.new(card_params)
    @decks = Deck.all
    deck = Deck.find_by(id: params[:card][:deck_id])

    respond_to do |format|
      if params[:card][:deck_id].present? && deck && @card.save
        @card.decks << deck

        format.html { redirect_to deck_card_path(deck.id, @card.id), notice: 'Card was successfully saved.' }
        format.json { render :show, status: :created, location: :card }
      else
        format.html { render :new, status: :bad_request }
        format.json { render json: @card.errors, status: :bad_request}
      end
    end
  end

  def edit; end

  def update; end

  def destroy; end

  private

  def card_params
    params.require(:card).permit(:title, :face_content, :back_content)
  end
end