Rails.application.routes.draw do
  devise_for :users, :controllers => { registrations: 'users/registrations' }
  root "home#home"
  get 'users', to: "home#home"

  resources :categories, only: [:index, :new, :create]  do
    resources :exchanges, only: [:index, :new, :create]
  end

end
