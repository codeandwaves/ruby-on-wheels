require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  context "when the resource is a Car" do
    describe "POST /create" do
      it "returns http success" do
        car = create(:car)
        post "/api/v1/cars/#{car.id}/favorites"
        expect(response).to have_http_status(:success)
      end
    end

    describe "GET /destroy" do
      it "returns http success" do
        car = create(:car)
        delete "/api/v1/cars/#{car.id}/favorites"
        expect(response).to have_http_status(:success)
      end
    end

  end
end
