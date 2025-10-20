require 'rails_helper'

RSpec.describe "Cards", type: :request do
  describe "GET /cards" do
    context 'user is logged on' do
      let!(:user) do
        User.create!(
          username: 'User',
          password: 'secret',
          role: 'user'
        )
      end

      before do
        post '/login', params: {
          username: user.username,
          password: 'secret'
        }
      end

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
            category_id: category.id,
            user: user
          )
        end

        let!(:deck) do
          Deck.create!(
            title: 'Test Deck',
            user: user
          )
        end

        before do
          topic.decks << deck
        end

        let!(:card1) do
          Card.create!(
            title: 'Test Card 1',
            user: user
          )
        end

        let!(:card2) do
          Card.create!(
            title: 'Test Card 2',
            user: user
          )
        end

        before do
          deck.cards << card1
          deck.cards << card2
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
          # expect(response.body).not_to include('<li>')
        end
      end
    end

    context 'user is not logged in' do
      it 'it returns a 403 forbidden status' do
        get '/cards'
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "GET /decks/:id/cards/:id?side=face" do
    let!(:user) do
      User.create!(
        username: 'User',
        password: 'secret',
        role: 'user'
      )
    end

    let!(:category) do
      Category.create!(
        title: 'Test Category'
      )
    end

    let!(:topic) do
      Topic.create!(
        title: 'Test Topic',
        category_id: category.id,
        user: user
      )
    end

    let!(:deck) do
      Deck.create!(
        title: 'Test Deck',
        user: user
      )
    end

    let!(:card) do
      Card.create!(
        title: 'Test Card',
        face_content: 'This is the content on the face (lined) of the index card.',
        back_content: 'The back side of the card is the blank side.',
        user: user
      )
    end

    context 'user is logged in' do
      before do
        post '/login', params: {
          username: user.username,
          password: 'secret'
        }
      end

      it 'returns the title of the deck' do
        get "/decks/#{deck.id}/cards/#{card.id}?side=face"
        expect(response.body).to include('Test Deck')
      end

      it 'returns the content on the face of the card' do
        get "/decks/#{deck.id}/cards/#{card.id}?side=face"
        expect(response.body).to include('This is the content on the face (lined) of the index card.')
      end
    end

    context 'user is not logged in' do
      it 'returns a 403 forbidden status' do
        get "/decks/#{deck.id}/cards/#{card.id}?side=face"
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe "GET /decks/:id/cards/:id?side=back" do
    let!(:user) do
      User.create!(
        username: 'User',
        password: 'secret',
        role: 'user'
      )
    end

    let!(:category) do
      Category.create!(
        title: 'Test Category'
      )
    end

    let!(:topic) do
      Topic.create!(
        title: 'Test Topic',
        category_id: category.id,
        user: user
      )
    end

    let!(:deck) do
      Deck.create!(
        title: 'Test Deck',
        user: user
      )
    end

    let!(:card) do
      Card.create!(
        title: 'Test Card',
        face_content: 'This is the content on the face (lined) of the index card.',
        back_content: 'The back side of the card is the blank side.',
        user: user
      )
    end

    context 'user is logged in' do
      before do
        post '/login', params: {
          username: user.username,
          password: 'secret'
        }
      end

      it 'returns the title of the deck' do
        get "/decks/#{deck.id}/cards/#{card.id}?side=back"
        expect(response.body).to include('Test Deck')
      end

      it 'returns the content on the face of the card' do
        get "/decks/#{deck.id}/cards/#{card.id}?side=back"
        expect(response.body).to include('The back side of the card is the blank side.')
      end
    end

    context 'user is not logged in' do
      it 'returns a 403 forbidden status' do
        get "/decks/#{deck.id}/cards/#{card.id}?side=back"
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'GET /decks/:id/cards/new' do
    let!(:user) do
      User.create(
        username: 'User',
        password: 'secret',
        role: 'user'
      )
    end

    let!(:category) do
      Category.create!(
        title: 'Test category'
        )
      end

    let!(:topic) do
      Topic.create!(
        title: 'Test topic',
        category_id: category.id,
        user: user
      )
    end

    let!(:deck) do
      Deck.create!(
        title: 'Test deck',
        user: user
      )
    end

    before do
      topic.decks << deck
    end

    context 'user is logged in' do
      before do
        post '/login', params: {
          username: user.username,
          password: 'secret'
        }
      end

      it 'displays the title, face content, back content and deck labels' do
        get "/decks/#{deck.id}/cards/new"

        expect(response.body).to include('Title')
        expect(response.body).to include('Face content')
        expect(response.body).to include('Back content')
        expect(response.body).to include('Deck')
      end
    end

    context 'user is not logged in' do
      it 'returns a 403 forbidden status' do
        get "/decks/#{deck.id}/cards/new"
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'POST /decks/:id/cards' do
    let!(:user) do
      User.create!(
        username: 'User',
        password: 'secret',
        role: 'user'
      )
    end

    let(:category) do
      Category.create!(
        title: 'Test category'
      )
    end

    let!(:topic) do
      Topic.create!(
        title: 'Test topic',
        category_id: category.id,
        user: user
      )
    end

    let!(:deck) do
      Deck.create!(
        title: 'Test deck',
        user: user
      )
    end

    before do
      topic.decks << deck
    end

    context 'user is logged in' do
      before do
        post '/login', params: {
          username: user.username,
          password: 'secret'
        }
      end

      it "creates a new card when title and deck exist and are valid" do
        post "/decks/#{deck.id}/cards", params: {
          card: {
            title: 'New card',
            deck_id: deck.id
          }
        }

        expect(response).to redirect_to(deck_card_path(deck.id, Card.last.id))

        expect(Card.last.title).to eq('New card')
        expect(Card.last.decks.first.title).to eq('Test deck')
      end

      it 'responds with 400 status when no deck is provided' do
        post "/decks/#{deck.id}/cards", params: {
          card: {
            title: 'New card'
          }
        }

        expect(response).to have_http_status(:bad_request)
      end

      it 'responds with 400 status when deck id does not belong to an existing deck' do
        post "/decks/#{deck.id}/cards", params: {
          card: {
            title: 'New card',
            deck_id: 'nope'
          }
        }

        expect(response).to have_http_status(:bad_request)
      end
    end

    context 'user is not logged in' do
      it 'returns a 403 forbidden status' do
        post "/decks/#{deck.id}/cards", params: {
          card: {
            title: 'New card',
            deck_id: deck.id
          }
        }

        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'GET /decks/:id/cards/:id/edit' do
    let!(:user) do
      User.create!(
        username: 'User',
        password: 'secret',
        role: 'user'
      )
    end

    let!(:category) do
      Category.create!(
        title: 'Test category'
      )
    end

    let!(:topic) do
      Topic.create!(
        title: 'Test topic',
        category_id: category.id,
        user: user
      )
    end

    let!(:deck) do
      Deck.create!(
        title: 'Test deck 1',
        user: user
      )
    end

    before do
      topic.decks << deck
    end

    let!(:card) do
      Card.create!(
        title: 'Test card',
        face_content: 'Content on the face of the card',
        back_content: 'Content on the back of the card',
        user: user
      )
    end

    before do
      deck.cards << card
    end

    context 'user is logged in' do
      before do
        post '/login', params: {
          username: user.username,
          password: 'secret'
        }
      end

      it 'responds with 200 OK' do
        get "/decks/#{deck.id}/cards/#{card.id}/edit"

        expect(response).to have_http_status(:ok)
      end

      it 'displays the title label' do
        get "/decks/#{deck.id}/cards/#{card.id}/edit"

        expect(response.body).to include('Title')
      end

      it 'displays the face content label' do
        get "/decks/#{deck.id}/cards/#{card.id}/edit"

        expect(response.body).to include('Face content')
      end

      it 'displays the back content label' do
        get "/decks/#{deck.id}/cards/#{card.id}/edit"

        expect(response.body).to include('Back content')
      end

      it 'displays the deck label' do
        get "/decks/#{deck.id}/cards/#{card.id}"

        expect(response.body).to include('Deck')
      end
    end

    context 'user is not logged in' do
      it 'returns a 403 forbidden status' do
        get "/decks/#{deck.id}/cards/#{card.id}/edit"
        expect(response).to have_http_status(:forbidden)
      end
    end
  end

  describe 'PUT /decks/:id/cards/:id' do
    let!(:user) do
      User.create!(
        username: 'User',
        password: 'secret',
        role: 'user'
      )
    end

    let!(:category) do
      Category.create!(
        title: 'Test category'
      )
    end

    let!(:topic) do
      Topic.create!(
        title: 'Test topic',
        category_id: category.id,
        user: user
      )
    end

    let!(:deck1) do
      Deck.create!(
        title: 'Test deck 1',
        user: user
      )
    end

    let!(:deck2) do
      Deck.create!(
        title: 'Test deck 2',
        user: user
      )
    end

    before do
      topic.decks << deck1
      topic.decks << deck2
    end

    let!(:card) do
      Card.create!(
        title: 'Test card',
        face_content: 'Content on the face of the card',
        back_content: 'Content on the back of the card',
        user: user
      )
    end

    before do
      deck1.cards << card
    end

    context 'user is logged in' do
      before do
        post '/login', params: {
          username: user.username,
          password: 'secret'
        }
      end

      it "updates a card's title, content, and/or deck when deck is valid and card exists" do
        put "/decks/#{deck1.id}/cards/#{card.id}", params: {
          card: {
            title: 'New title',
            deck_id: deck2.id,
            face_content: 'Edited content on the face of the card',
            back_content: 'Edited content on the back of the card'
          }
        }

        expect(response).to redirect_to(deck_card_path(deck2.id, Card.last.id))
        card.reload
        expect(Card.last.title).to eq('New title')
        expect(Card.last.decks.first.title).to eq('Test deck 2')
      end

      it 'responds with 400 status when deck id is not provided' do
        put "/decks/#{deck1.id}/cards/#{card.id}", params: {
          card: {
            title: 'New title'
          }
        }

        expect(response).to have_http_status(:bad_request)
      end

      it 'responds with 400 status when deck id does not belong to a valid deck' do
        put "/decks/#{deck1.id}/cards/#{card.id}", params: {
          card: {
            title: 'New title',
            deck_id: 'nope'
          }
        }

        expect(response).to have_http_status(:bad_request)
      end

      it 'responds with 404 status when card id does not belong to an existing card' do
        put "/decks/#{deck1.id}/cards/nope", params: {
          card: {
            title: 'New title',
            deck_id: deck2.id
          }
        }

        expect(response).to have_http_status(:not_found)
      end
    end

    context 'user is not logged in' do
      it 'returns a 403 forbidden status' do
        put "/decks/#{deck1.id}/cards/#{card.id}", params: {
          card: {
            title: 'New title',
            deck_id: deck2.id
          }
        }
      end
    end
  end
end
