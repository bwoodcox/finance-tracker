Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'my_friends', to: 'users#my_friends'
  get 'search_stock', to: 'stocks#search'
  get 'search_friend', to: 'users#search'
  resources :user_stocks, only: [:create, :destroy]
  resources :friendships, only: [:create, :destroy]
end