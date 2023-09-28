Rails.application.routes.draw do
  get 'admin_dashboard/index'
  get 'landing_page/index'
  root 'landing_page#index'

  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'

  resources :reviews
  resources :passengers
  resources :tickets
  resources :trains
  resources :admins
end
