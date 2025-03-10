Rails.application.routes.draw do
  root to: "tasks#index"
  devise_for :users
  resources :tasks
  resources :subscriptions, only: %i[new create destroy]

  # get "up" => "rails/health#show", as: :rails_health_check
  post "/webhooks/stripe", to: "webhooks#stripe"
end
