require 'rails_helper'

RSpec.describe "Topics", type: :request do
  describe 'GET/topics/:id', type: :request do
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

    it 'responds with 200 OK' do
      get "/topics/#{topic.id}"

      expect(response).to have_http_status(:ok)
    end

    it 'returns a page containing the topic title' do
      get "/topics/#{topic.id}"

      expect(response.body).to include('Test Topic')
    end

    context 'decks exist' do
      let!(:deck1) do
        Deck.create!(
          title: 'Test Deck 1',
        )
      end

      let!(:deck2) do
        Deck.create!(
          title: 'Test Deck 2',
          )
        end

      before do
        topic.decks << deck1
        topic.decks << deck2
      end

      it "returns a page containing titles of all the topic's decks" do
        get "/topics/#{topic.id}"

        expect(response.body).to include('Test Deck 1')
        expect(response.body).to include('Test Deck 2')
      end

      it 'links each deck to the deck show page' do
        get "/topics/#{topic.id}"

        expect(response.body).to include("decks/#{deck1.id}")
        expect(response.body).to include("decks/#{deck2.id}")
      end
    end
  end
end
