require 'rails_helper'

RSpec.describe "Cars", type: :request do
  describe "GET /api/v1/cars" do
    it "returns all cars" do
      create_list(:car, 5)

      get "/api/v1/cars"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).length).to eq(5)
    end
  end

  describe "GET /api/v1/cars/:id" do
    it "returns a car" do
      car = create(:car)

      get "/api/v1/cars/#{car.id}"
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).keys).to eq(["id", "brand", "mileage", "name"])
    end
  end
end
