class DecksController < ApplicationController
  before_action :require_user

  def show
    @current_user = User.find_by(id: session[:user_id])
    @deck = @current_user.decks.find(params[:id])
    @cards = @current_user.cards
  end

  def new
    @current_user = User.find_by(id: session[:user_id])
    @deck = @current_user.decks.new
    @topics = @current_user.topics
  end

  def create
    @current_user = User.find_by(id: session[:user_id])
    @deck = @current_user.decks.new(deck_params)
    @topics = @current_user.topics

    respond_to do |format|
      if params[:deck][:topic_id].present?
        topic = Topic.find_by(id: params[:deck][:topic_id])
        if topic
          if @deck.save
            @deck.topics << topic

            format.html { redirect_to deck_path(@deck), notice: 'Deck was successfully saved.' }
            format.json { render :show, status: :created, location: :deck }
          else
            format.html { render :new, status: :bad_request }
            format.json { render json: @deck.errors, status: :bad_request }
          end
        else
          format.html { render :new, status: :bad_request }
          format.json { render json: @deck.errors, status: :bad_request }
        end
      else
        format.html { render :new, status: :bad_request }
        format.json { render json: @deck.errors, status: :bad_request }
      end
    end
  end

  def edit
    @current_user = User.find_by(id: session[:user_id])
    @deck = @current_user.decks.includes(:cards).find(params[:id])
    @topics = @current_user.topics
  end

  def update
    @current_user = User.find_by(id: session[:user_id])
    @deck = @current_user.decks.includes(:cards).find(params[:id])
    @topics = @current_user.topics
    topic = @current_user.topics.find_by(id: params[:deck][:topic_id])

    respond_to do |format|
      if params[:deck][:topic_id].present? && topic && @deck.update(deck_params)
        @deck.topics = [topic]

        format.html { redirect_to @deck, notice: 'Deck was successfully updated.' }
        format.json { render :show, status: :ok, location: :deck }
      else
        format.html { render :edit, status: :bad_request }
        format.json { render json: @deck.errors, status: :bad_request }
      end
    end
  end

  def destroy; end

  private

  def deck_params
    params.require(:deck).permit(:title)
  end
end