Rails.application.routes.draw do
  devise_for :users, :controllers => { :registrations => 'registrations'}
  post "/users/new" => "users#create"
    # config/routes.rb
    # Rails.application.routes.draw do
    #   devise_for :users
    # end
  resources :users
  resources :projects
  resources :daily_work_reports
  get 'home/index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get 'users/index'
  # Defines the root path route ("/")
  # root "articles#index"

  root to: "home#index" 
end
