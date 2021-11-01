Rails.application.routes.draw do
  namespace :api, defaults: { format: :json } do
    namespace :v1 do
      resources :cars, only: %i(index show)

      post "/login", to: "auth#login"
      get "/auth", to: "auth#persist"
    end
  end
end
