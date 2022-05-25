Rails.application.routes.draw do
  resources :exchanges
  resources :slots
  resources :categories
  devise_for :users, :controllers => { registrations: 'users/registrations' }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
end
