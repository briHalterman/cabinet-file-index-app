class DecksController < ApplicationController
  before_action :require_user

  def show
    @deck = Deck.find(params[:id])
    @cards = @deck.cards
  end

  def new
    @deck = Deck.new
    @topics = Topic.all
  end

  def create
    @deck = Deck.new(deck_params)
    @topics = Topic.all

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
    @deck = Deck.find(params[:id])
    @topics = Topic.all
  end

  def update
    @deck = Deck.find(params[:id])
    @topics = Topic.all
    topic = Topic.find_by(id: params[:deck][:topic_id])

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