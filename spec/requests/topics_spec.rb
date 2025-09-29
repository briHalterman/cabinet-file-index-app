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

  describe 'GET /topics/new' do
    it 'displays the title and category labels' do
      get '/topics/new'
      expect(response.body).to include('Title')
      expect(response.body).to include('Category')
    end
  end

  describe 'POST /topics' do
    let!(:category) do
      Category.create!(
        title: 'Test category'
      )
    end

    it "creates a new topic when title and category exist and are valid" do
      post "/topics", params: {
        topic: {
          title: "New topic",
          category_id: category.id
        }
      }

      expect(response).to redirect_to(topic_path(Topic.last))

      expect(Topic.last.title).to eq('New topic')
      expect(Topic.last.category.title).to eq('Test category')
    end

    it "responds with 400 status when no category is provided" do
      post "/topics", params: {
        topic: {
          title: "New topic"
        }
      }

      expect(response).to have_http_status(:bad_request)
    end

    it "responds with 400 status when category id does not belong to an existing category" do
      post "/topics", params: {
        topic: {
          title: "New topic",
          category_id: 'nope'
        }
      }

      expect(response).to have_http_status(:bad_request)
    end
  end

  describe 'GET /topics/:id/edit' do
    let!(:category) do
      Category.create!(
        title: "Test category"
      )
    end

    let!(:topic) do
      Topic.create!(
        title: "Test Topic",
        category_id: category.id
      )
    end

    it 'responds with 200 OK' do
      get "/topics/#{topic.id}/edit"

      expect(response).to have_http_status(:ok)
    end

    it 'displays the title label' do
      get "/topics/#{topic.id}/edit"

      expect(response.body).to include('Title')
    end

    it 'displays the category label' do
      get "/topics/#{topic.id}/edit"

      expect(response.body).to include('Category')
    end
  end
end
