Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  mount_griddler

  resources :users, except: [:new, :create, :show]

  resources :teams, shallow: true do
    resources :seats, except: [:index, :show]
  end
end
