require 'rails_helper'

RSpec.describe "Dashboard", type: :request do
  describe "GET /dashboard" do
    it "returns a 200 OK status" do
      get "/dashboard"
      expect(response).to have_http_status(:ok)
    end

    it 'displays links to categories' do
    end

    it 'displays links to the most recently edited topics in each category' do
    end
  end
end
