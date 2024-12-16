Rails.application.routes.draw do
  root to: "tasks#index"
  devise_for :users
  resources :tasks

  get "up" => "rails/health#show", as: :rails_health_check
end
