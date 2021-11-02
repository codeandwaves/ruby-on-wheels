Rails.application.routes.draw do

  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :cars, only: %i(index show)

      post "cars/:car_id/favorites", to: "favorites#create"
      delete "cars/:car_id/favorites", to: "favorites#destroy"
    end
  end
end
