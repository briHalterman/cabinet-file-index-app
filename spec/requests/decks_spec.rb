require 'rails_helper'

RSpec.describe "Decks", type: :request do
  describe 'GET/decks/:id', type: :request do
    let!(:category) do
      Category.create!(
        title: 'Test Category'
      )
    end

    let!(:topic) do
      Topic.create!(
        title: 'Test Topic',
        category_id: category.id
      )
    end

    let!(:deck) do
      Deck.create!(
        title: 'Test Deck',
      )
    end

    before do
      topic.decks << deck
    end

    it 'responds with 200 OK' do
      get "/decks/#{deck.id}"

      expect(response).to have_http_status(:ok)
    end

    it 'returns a page containing the deck title' do
      get "/decks/#{deck.id}"

      expect(response.body).to include('Test Deck')
    end

    context 'decks exist' do
      let!(:card1) do
        Card.create!(
          title: 'Test Card 1',
        )
      end

      let!(:card2) do
        Card.create!(
          title: 'Test Card 2',
          )
        end

      before do
        deck.cards << card1
        deck.cards << card2
      end

      it "returns a page containing titles of all the deck's cards" do
        get "/decks/#{deck.id}"

        expect(response.body).to include('Test Card 1')
        expect(response.body).to include('Test Card 2')
      end

      it 'links each card to the card face show page' do
        get "/decks/#{deck.id}"

        expect(response.body).to include("cards/#{card1.id}?side=face")
        expect(response.body).to include("cards/#{card2.id}?side=face")
      end
    end
  end

  describe 'GET /decks/new' do
    it 'displays the title and topic labels' do
      get '/topics/new'
      expect(response.body).to include('Title')
      expect(response.body).to include('Topic')
    end
  end
end
