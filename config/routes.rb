Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :teams, only: [:index, :show]
end
