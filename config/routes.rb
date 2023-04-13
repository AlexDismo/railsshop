Rails.application.routes.draw do
  devise_for :users
  get '/account', to: 'devise/registrations#edit'
  root 'main#index', as:'home'
  resources :products do
    post 'add_item', on: :member
    end
  resources :users
  resources :carts
  delete 'carts/remove_item/:product_id', to: 'carts#remove_item', as: 'remove_item'
  delete 'clear_cart', to: 'carts#clear_cart', as: 'clear_cart'
  post '/checkout', to: 'carts#checkout', as: 'checkout'
  get '/orders', to: 'carts#user_orders', as: 'orders'


  resources :orders, only: [:new, :create, :index]
end
