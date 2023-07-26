Rails.application.routes.draw do


  devise_for :users, skip: [:registrations]
  #  :controllers => { :registrations => 'registrations'}
  
  
  # post "/users/new" => "users#create"
    # config/routes.rb
    # Rails.application.routes.draw do

    #   devise_for :users
    # end
  # post "/email_hierarchy/new" => "email_hierarchy#create"
  resources :users
  resources :projects
  resources :daily_work_reports
  resources :email_hierarchy
  resources :attendances 
  resources :designations
  resources :departments
  resources :holidays
  namespace :api do
    namespace :v1,defaults: { format: 'json' } do
      post   '/login'  => 'users#create'
      delete '/logout' => 'users#destroy'
      get '/daily_work_reports' => 'daily_work_reports#index'
      get '/attendance' => 'attendance#index'
    end
  end
  # get 'home/index'
  get 'work/check_index' => 'daily_work_reports#check_index'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get 'users/index'
  # Defines the root path route ("/")
  # root "articles#index"

  root to: "home#index" 
end
