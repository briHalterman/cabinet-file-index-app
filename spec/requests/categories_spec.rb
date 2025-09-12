require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /categories" do
    it 'responds with 200 OK' do
      get "/categories"
      expect(response).to have_http_status(:ok)
    end

    context 'categories exist' do
      before do
        Category.create!(
          title: 'Category 1'
        )

        Category.create!(
          title: 'Category 2'
        )
      end

      it 'returns a page containing titles of all categories' do
        get '/categories'
        expect(response.body).to include('Category 1')
        expect(response.body).to include('Category 2')
      end
    end

    context 'categories do not exist' do
      it 'returns a page containing no names of categories' do
        get '/categories'
        expect(response.body).to include('Categories')
        expect(response.body).not_to include('<li>')
      end
    end
  end
end
