Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :teams, shallow: true do
    resources :seats, except: [:index, :show]
  end
end
