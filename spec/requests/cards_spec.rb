require 'rails_helper'

RSpec.describe "Cards", type: :request do
  describe "GET /cards" do
    it 'responds with 200 OK' do
      get "/cards"
      expect(response).to have_http_status(:ok)
    end

    context 'categories exist' do
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

      let!(:card1) do
        Card.create!(
          title: 'Test Card 1'
        )
      end

      let!(:card2) do
        Card.create!(
          title: 'Test Card 2'
        )
      end

      it 'returns a page containing titles of all cards' do
        get '/cards'
        expect(response.body).to include('Test Card 1')
        expect(response.body).to include('Test Card 2')
      end
    end

    context 'categories do not exist' do
      it 'returns a page containing no names of cards' do
        get '/cards'
        expect(response.body).to include('All Cards')
        expect(response.body).not_to include('<li>')
      end
    end

  end

  describe "GET /cards/:id?side=face" do
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

      let!(:card) do
        Card.create!(
          title: 'Test Card',
          face_content: 'This is the content on the face (lined) of the index card.',
          back_content: 'The back side of the card is the blank side.'
        )
      end

      it 'returns the content on the face of the card' do
        get "/cards/#{card.id}?side=face"
        expect(response.body).to include('This is the content on the face (lined) of the index card.')
      end
  end

    describe "GET /cards/:id?side=back" do
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

      let!(:card) do
        Card.create!(
          title: 'Test Card',
          face_content: 'This is the content on the face (lined) of the index card.',
          back_content: 'The back side of the card is the blank side.'
        )
      end

      it 'returns the content on the face of the card' do
        get "/cards/#{card.id}?side=back"
        expect(response.body).to include('The back side of the card is the blank side.')
      end
  end
end
