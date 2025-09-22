require 'rails_helper'

RSpec.describe "Categories", type: :request do
  describe "GET /categories" do
    it 'responds with 200 OK' do
      get "/categories"
      expect(response).to have_http_status(:ok)
    end

    context 'categories exist' do
      let!(:category1) {
        Category.create!(
        title: 'Test Category 1'
        )
      }

      let!(:category2) {
        Category.create!(
        title: 'Test Category 2'
        )
      }

      it 'returns a page containing titles of all categories' do
        get '/categories'
        expect(response.body).to include('Test Category 1')
        expect(response.body).to include('Test Category 2')
      end

      it 'links each category to the category show page' do
        get '/categories'

        expect(response.body).to include("categories/#{category1.id}")
        expect(response.body).to include("categories/#{category2.id}")
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
