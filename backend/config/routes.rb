Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      # get all favorites from a user
      get "/cars/favorites", to: "favorites#index"

      get "/cars", to: "cars#index"
      get "/cars/:id", to: "cars#show"

      # post "favorites/:klass/:klass_id", to: "favorites#create"
      post "/cars/:car_id/favorites", to: "favorites#create"
      delete "/cars/:car_id/favorites", to: "favorites#destroy"

      post "login", to: "auth#login"
      get "auth", to: "auth#persist"
    end
  end
end
