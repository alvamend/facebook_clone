Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Added signup route to create new users
      post "/signup", to: "users#create"

      # Post routes
      resources :posts

      # Auth routes
      post "/auth/login", to: "auth#create"
      delete "/auth/logout", to: "auth#destroy"
    end
  end
end
