Rails.application.routes.draw do
  root 'welcome#index'
  devise_for :users
  get 'my_portfolio', to: 'users#my_portfolio'
  get 'search_stock', to: 'stocks#search'
  get 'stocks/search_stock'
  resources :user_stocks, only: [:create]
end