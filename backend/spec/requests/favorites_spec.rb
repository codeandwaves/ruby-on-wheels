require 'rails_helper'

RSpec.describe "Favorites", type: :request do
  describe "POST /create" do
    it "creates a new favorite" do
      favorite = create(:favorite)

      expect {
        post "/api/v1/cars/#{favorite.car.id}/favorites", headers: { "Authorization" => "Bearer #{favorite.user.generate_jwt}"}
      }.to change { Favorite.count }.by(1)

      expect(response).to have_http_status(:created)
    end
  end

  describe "DELETE /cars/:id/favorites" do

    it "deletes a favorite" do
      favorite = create(:favorite)

      expect {
        delete "/api/v1/cars/#{favorite.car.id}/favorites", headers: { "Authorization" => "Bearer #{favorite.user.generate_jwt}"}
      }.to change { Favorite.count }.by(-1)

      expect(response).to have_http_status(:no_content)
    end
  end

  describe "GET /cars/favorites" do
    let(:user) { create(:favorite).user }

    it "returns all favorites from a user" do
      get "/api/v1/cars/favorites", headers: { "Authorization" => "Bearer #{user.generate_jwt}"}

      expect(response).to have_http_status(:success)
    end
  end
end
