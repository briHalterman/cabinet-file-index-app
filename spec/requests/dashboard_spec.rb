require 'rails_helper'

RSpec.describe "AdminDashboards", type: :request do
  describe "GET /dashboard" do
    it "returns a 200 OK status" do
      get "/dashboard"
      expect(response).to have_http_status(:ok)
    end
  end
end
