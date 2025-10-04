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

  describe 'POST /decks' do
    let!(:category) do
      Category.create!(
        title: 'Test category'
      )
    end

    let!(:topic) do
      Topic.create!(
        title: 'Test topic',
        category_id: category.id
      )
    end

    it "creates a new deck when title and topic exist and are valid" do
      post '/decks', params: {
        deck: {
          title: 'New deck',
          topic_id: topic.id
        }
      }

      expect(response).to redirect_to(deck_path(Deck.last))

      expect(Deck.last.title).to eq('New deck')
      expect(Deck.last.topics.first.title).to eq('Test topic')
    end

    it 'responds with 400 status when no topic is provided' do
      post '/decks', params: {
        deck: {
          title: 'New topic'
        }
      }

      expect(response).to have_http_status(:bad_request)
    end

    it 'responds with 400 status when topic id does not belong to an existing topic' do
      post '/decks', params: {
        deck: {
          title: 'New topic',
          topic_id: 'nope'
        }
      }

      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'GET /decks/:id/edit' do
    let!(:category) do
      Category.create!(
        title: 'Test category'
      )
    end

    let!(:topic) do
      Topic.create!(
        title: 'Test topic',
        category_id: category.id
      )
    end

    let!(:deck) do
      Deck.create!(
        title: 'Test deck'
      )
    end

    before do
      topic.decks << deck
    end

    it 'responds with 200 OK' do
      get "/decks/#{deck.id}/edit"

      expect(response).to have_http_status(:ok)
    end

    it 'displays the title label' do
      get "/decks/#{deck.id}/edit"

      expect(response.body).to include('Title')
    end

    it 'displays the topic label' do
      get "/decks/#{deck.id}/edit"

      expect(response.body).to include('Topic')
    end
  end

  describe 'PUT /decks/:id' do
    let(:category) do
      Category.create!(
        title: 'Test category 1'
      )
    end

    let!(:topic1) do
      Topic.create!(
        title: 'Test topic 1',
        category_id: category.id
      )
    end

    let(:topic2) do
      Topic.create!(
        title: 'Test topic 2',
        category_id: category.id
      )
    end

    let!(:deck) do
      Deck.create!(
        title: 'Test deck'
      )
    end

    before do
      topic1.decks << deck
    end

    it "updates a deck's title and/or topic when topic is valid and deck exists" do
      put "/decks/#{deck.id}", params: {
        deck: {
          title: 'New title',
          topic_id: topic2.id
        }
      }

      expect(response).to redirect_to(deck)
      deck.reload
      expect(Deck.last.title).to eq('New title')
      expect(Deck.last.topics.first.title).to eq('Test topic 2')
    end
  end
end
