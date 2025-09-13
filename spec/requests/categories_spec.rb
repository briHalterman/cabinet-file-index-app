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

  describe 'GET/categories/:id', type: :request do
    let!(:category) do
      Category.create!(
        title: 'Test Category'
      )
    end

    it 'responds with 200 OK' do
      get "/categories/#{category.id}"

      expect(response).to have_http_status(:ok)
    end

    it 'returns a page containing the category' do
      get "/categories/#{category.id}"

      expect(response.body).to include('Test Category')
    end

    context 'categories exist' do
      let!(:topic1) do
        Topic.create!(
          title: 'Test Topic 1',
          category_id: category.id
        )
      end

      let!(:topic2) do
        Topic.create!(
          title: 'Test Topic 2',
          category_id: category.id
        )
      end

      it "returns a page containing titles of all the category's topics" do
        get "/categories/#{category.id}"

        expect(response.body).to include('Test Topic 1')
        expect(response.body).to include('Test Topic 2')
      end

    end
  end
end
