Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :teams, only: [:index, :show, :new, :create], shallow: true do
    resources :seats, except: [:index, :show]
  end
end
