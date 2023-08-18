Rails.application.routes.draw do
  resources :other_work_reports


  devise_for :users, skip: [:registrations] 
  #  :controllers => { :registrations => 'registrations'}
  
  
  # post "/users/new" => "users#create"
    # config/routes.rb
    # Rails.application.routes.draw do
  # resources :other_work_reports

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
  resources :check_in_outs
  namespace :api do
    namespace :v1,defaults: { format: 'json' } do
      post   '/login'  => 'users#create'
      post '/check_in' => 'check_in_out#create'
      put '/check_out' => 'check_in_out#update'
      delete '/logout' => 'users#destroy'
      get '/daily_work_reports' => 'daily_work_reports#index'
      get '/attendance' => 'attendance#index'
    end
  end
  # get 'home/index'
  get 'work/check_index' => 'daily_work_reports#check_index'
  get 'attendance/check_attendance' => 'attendances#check_attendance'
  get 'check_in/other_in_out' => 'check_in_outs#other_in_out'
  post 'check_in/other_in_out' => 'check_in_outs#create_other'

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  # get 'users/index'
  # Defines the root path route ("/")
  # root "articles#index"

  root to: "home#index" 
end
