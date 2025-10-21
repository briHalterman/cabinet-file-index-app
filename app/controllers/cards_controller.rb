class CardsController < ApplicationController
  before_action :require_user
  before_action :set_card, only: %i[show edit update destroy]

  def index
    @current_user = User.find_by(id: session[:user_id])
    # @deck = @current_user.decks.includes(:cards).find(params[:deck_id])
    @cards = @current_user.cards
  end

  def show
    @current_user = User.find_by(id: session[:user_id])
    # @deck = @current_user.decks.includes(:cards).find(params[:deck_id])
    @deck = Deck.where(id: params[:deck_id], user_id: @current_user.id).first
    @card = @deck.cards.find_by(id: params[:id])

    if params[:side] == "face"
      @content = @card.face_content
    elsif params[:side] == "back"
      @content = @card.back_content
    end
  end

  def new
    @current_user = User.find_by(id: session[:user_id])
    @deck = @current_user.decks.includes(:cards).find(params[:deck_id])
    @card = @deck.cards.build
    @decks = @current_user.decks
  end

  def create
    @current_user = User.find_by(id: session[:user_id])
    @deck = @current_user.decks.includes(:cards).find(params[:deck_id])
    @card = @deck.cards.build(card_params)
    @decks = @current_user.decks
    # deck = @current_user.decks.find_by(id: params[:card][:deck_id])
    # user: current_user
    @card.user = @current_user

    respond_to do |format|
      if @card.save
      # if params[:card][:deck_id].present? && deck && @card.save
        # @card.decks << deck
        @card.decks = @current_user.decks.where(id: card_params[:deck_ids])

        format.html { redirect_to deck_card_path(@deck, @card), notice: 'Card was successfully saved.' }
        format.json { render :show, status: :created, location: :card }
      else
        format.html { render :new, status: :bad_request }
        format.json { render json: @card.errors, status: :bad_request}
      end
    end
  end

  def edit
    @current_user = User.find_by(id: session[:user_id])
    @deck = @current_user.decks.includes(:cards).find_by(id: params[:deck_id])
    # debugger
    @card = @deck.cards.find(params[:id])
    @decks = @current_user.decks
  end

  def update
    @current_user = User.find_by(id: session[:user_id])
    @deck = @current_user.decks.includes(:cards).find(params[:deck_id])
    @card = @deck.cards.find(params[:id])
    @decks = @current_user.decks
    # deck = @current_user.decks.find_by(id: params[:card][:deck_id])
    @card.user = @current_user
    # debugger
    respond_to do |format|
      if params[:card][:deck_ids].reject(&:blank?).any? && @card.update(card_params)
        @card.decks = @current_user.decks.where(id: card_params[:deck_ids])

        format.html { redirect_to deck_card_path(@deck, @card), notice: 'Card was successfully updated' }
        format.json { render :show, status: :ok, location: @card }
      else
        format.html { render :edit, status: :bad_request }
        format.json { render json: @card.errors, status: :bad_request }
      end
    end
  end

  def destroy; end

  private

  def card_params
    params.require(:card).permit(:title, :face_content, :back_content, deck_ids: [])
  end

  def set_card
    @card = Card.find(params[:id])
  end
end