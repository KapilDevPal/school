require 'rails_helper'

RSpec.describe "Schools::TransportDrivers", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/schools/transport_drivers/index"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /new" do
    it "returns http success" do
      get "/schools/transport_drivers/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /create" do
    it "returns http success" do
      get "/schools/transport_drivers/create"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /edit" do
    it "returns http success" do
      get "/schools/transport_drivers/edit"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /update" do
    it "returns http success" do
      get "/schools/transport_drivers/update"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /destroy" do
    it "returns http success" do
      get "/schools/transport_drivers/destroy"
      expect(response).to have_http_status(:success)
    end
  end

end
