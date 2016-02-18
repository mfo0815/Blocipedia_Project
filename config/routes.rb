Rails.application.routes.draw do

  devise_for :users, controllers: { registrations: "users/registrations" }
  resources :users, only: [:show]

  resources :wikis

  resources :charges, only: [:new, :create]
  delete '/downgrade', to: 'charges#downgrade'

  root to: 'welcome#index'

end
