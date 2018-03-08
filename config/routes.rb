Rails.application.routes.draw do
  root 'dashboard#show'

  get 'login', to: 'sessions#new'
  get 'logout', to: 'sessions#destroy'

  resources :sessions, only: [:create]
  resources :users, only: [:new, :create]

  	resources :users do
    	member do
      		get :confirm_email
    	end
  	end

end
