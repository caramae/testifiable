Samplesite1::Application.routes.draw do
  resources :admin_panels

  resources :datapoints do
    collection { post :import }
    collection { post :analyze }
  end

  resources :experiments
  post "experiments/enroll",          :as => :enroll
  post "experiments/reenroll",        :as => :reenroll
  post "experiments/unenroll",        :as => :unenroll
  post "experiments/randomize",       :as => :randomize
  post "experiments/accept_changes",  :as => :accept_changes

  resources :users do
    collection do 
      post :reset_password
    end
  end

  resources :sessions
  get "sessions/new", :as => :login

  root "static_pages#home"

  match '/',          to: 'static_pages#home',    via: 'get'
  match '/help',      to: 'static_pages#help',    via: 'get'
  match '/about',     to: 'static_pages#about',   via: 'get'
  match '/analyze',   to: 'static_pages#analyze', via: 'get'

end
