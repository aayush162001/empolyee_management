Rails.application.routes.draw do
  devise_for :users
  resources :users
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get 'users/index'
  # Defines the root path route ("/")
  # root "articles#index"
  root to: "home#index" 
end
