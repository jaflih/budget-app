Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root "home#home"

  resources :categories, only: [:index, :new, :create]  do
    resources :exchanges
  end

end
