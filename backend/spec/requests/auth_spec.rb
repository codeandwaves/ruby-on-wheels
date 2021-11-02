require 'rails_helper'

RSpec.describe "Auth", type: :request do

  context "when incorrect login credentials" do
    it "should return not authorized" do
      post "/api/v1/login", params: { email: "bademail@row.com", password: "wrongpassword" }
      expect(response).to have_http_status(:unauthorized)
    end
  end

  context "when correct login credentials" do
    it "should return token" do
      user = create(:user)
      post "/api/v1/login", params: { email: user.email, password: user.password }
      expect(response).to have_http_status(:success)
      expect(JSON.parse(response.body).keys).to eq(["user", "token"])
    end
  end
end
