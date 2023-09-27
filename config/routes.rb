Rails.application.routes.draw do
  resources :reviews
  resources :passengers
  resources :tickets
  resources :trains
  resources :admins
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end