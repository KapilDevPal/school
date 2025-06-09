require 'rails_helper'

RSpec.describe "Accountants::Dashboards", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/accountants/dashboard/index"
      expect(response).to have_http_status(:success)
    end
  end

end
