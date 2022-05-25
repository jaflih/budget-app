Rails.application.routes.draw do
  resources :exchanges
  resources :categories
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root "home#home"
end
