Rails.application.routes.draw do
  root 'home#index'

  resources :stocks
  resources :investments
  resources :portfolios

  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'


  devise_for :users

  get '/portfolios/:id/add', to: 'investments#create', as: 'add_investment_path'
end
