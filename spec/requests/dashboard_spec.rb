require 'rails_helper'

RSpec.describe "Dashboard", type: :request do
  describe "GET /dashboard" do
    before do
      @category1 = Category.create!(
        title: "Test Category 1"
      )

      @category2 = Category.create!(
        title: "Test Category 2"
      )

      @topic1 = Topic.create!(
        title: "Test Topic 1",
        category_id: @category1.id
      )

      @topic2 = Topic.create!(
        title: "Test Topic 2",
        category_id: @category1.id
      )

      @topic3 = Topic.create!(
        title: "Test Topic 3",
        category_id: @category1.id
      )

      @topic4 = Topic.create!(
        title: "Test Topic 2",
        category_id: @category1.id
      )

      @topic5 = Topic.create!(
        title: "Test Topic 5",
        category_id: @category2.id
      )

      @topic6 = Topic.create!(
        title: "Test Topic 6",
        category_id: @category2.id
      )

      @topic7 = Topic.create!(
        title: "Test Topic 7",
        category_id: @category2.id
      )

      @topic8 = Topic.create!(
        title: "Test Topic 8",
        category_id: @category2.id
      )
    end

    context 'user is logged in' do

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

      it "returns a 200 OK status" do
        get "/dashboard"
        expect(response).to have_http_status(:ok)
      end

      it 'displays categories' do
        get "/dashboard"

        expect(response.body).to include("Test Category 1")
        expect(response.body).to include("Test Category 2")
      end

      it 'displays links to the three most recently edited topics in each category' do
        get "/dashboard"

        expect(response.body).to include("/topics/#{@topic4.id}")
        expect(response.body).to include("/topics/#{@topic3.id}")
        expect(response.body).to include("/topics/#{@topic2.id}")

        expect(response.body).not_to include("/topics/#{@topic1.id}")

        expect(response.body).to include("/topics/#{@topic8.id}")
        expect(response.body).to include("/topics/#{@topic7.id}")
        expect(response.body).to include("/topics/#{@topic6.id}")

        expect(response.body).not_to include("/topics/#{@topic5.id}")
      end

      it "displays a link to view all of the category's topics" do
        get "/dashboard"

        expect(response.body).to include("/categories/#{@category1.id}")
        expect(response.body).to include("/categories/#{@category2.id}")
      end
    end
  end
end
