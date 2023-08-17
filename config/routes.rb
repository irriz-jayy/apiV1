Rails.application.routes.draw do
  resources :calendar_events
  resources :services
  resources :customers
  resources :appointments
  resources :admins
  post "/login", to: "auth#create"
  get "/profile", to: "admins#profile"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
