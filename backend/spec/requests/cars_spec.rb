require 'rails_helper'

RSpec.describe "Cars", type: :request do

  context 'No user authenticated' do
    describe "GET /api/v1/cars" do
      let(:user) { create(:user) }
      it 'returns unauthorized response' do
        get '/api/v1/cars'
        expect(response).to have_http_status(401)
      end
    end

    describe "GET /api/v1/cars/:id" do
      let(:user) { create(:user) }
      it 'returns unauthorized response' do
        car = create(:car)

        get "/api/v1/cars/#{car.id}"
        expect(response).to have_http_status(401)
      end
    end
  end

  context "User authenticated" do
    describe "GET /api/v1/cars" do
      let(:user) { create(:user) }

      it "returns all cars" do
        create_list(:car, 5)

        get "/api/v1/cars", headers: { "Authorization" => "Bearer #{user.generate_jwt}"}
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).length).to eq(5)
      end
    end

    describe "GET /api/v1/cars/:id" do
      let(:user) { create(:user) }

      it "returns a car" do
        car = create(:car)

        get "/api/v1/cars/#{car.id}", headers: { "Authorization" => "Bearer #{user.generate_jwt}" }
        expect(response).to have_http_status(:success)
        expect(JSON.parse(response.body).keys).to eq(["id", "brand", "mileage", "name"])
      end
    end
  end
end
