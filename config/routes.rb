Rails.application.routes.draw do
  root to: "home#index"
  devise_for :users
  mount_griddler

  resources :teams, shallow: true do
    resources :seats, except: [:index, :show]
  end
end
