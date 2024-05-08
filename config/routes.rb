Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      # Added signup route to create new users
      post "/signup", to: "users#create"
      resources :users, except: [:create]
    end
  end
end
