Rails.application.routes.draw do
  get 'admin_dashboard/index'
  get 'passenger_dashboard/index'
  get 'landing_page/index'
  root 'landing_page#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  get '/landing', to: 'passengers#landing_page'
  get '/signup', to: 'passengers#create'

  get '/userlogin', to: 'users#new'
  post '/userlogin', to: 'users#create'
  delete '/userlogout', to: 'users#destroy'


  resources :reviews
  resources :passengers
  resources :tickets
  resources :trains
  resources :admins
end
