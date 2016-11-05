Rails.application.routes.draw do
  devise_for :users
  root to: "home#index"

  resources :teams, only: [:index, :show, :new, :create, :edit, :update], shallow: true do
    resources :seats, except: [:index, :show]
  end
end
