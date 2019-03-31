Rails.application.routes.draw do
  get 'portfolios/all'
  get 'portfolios/new'
  get 'portfolios/create'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'
  resources :stocks
  root 'pages#home'

  devise_for :users, :path_prefix => 'd'
  resources :users
  match '/users',   to: 'users#index',   via: 'get'

  resources :portfolios
end
