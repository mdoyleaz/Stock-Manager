Rails.application.routes.draw do
  resources :stocks
  root 'pages#home'
  devise_for :users
end
