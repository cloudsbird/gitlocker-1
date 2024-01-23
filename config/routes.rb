Rails.application.routes.draw do
  devise_for :users, controllers: {
    registrations: "users/registrations",
    omniauth_callbacks: "users/omniauth_callbacks"
  }

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  # Defines the root path route ("/")
  root "home#index"

  get "dashboard", to: "dashboard#index"

  get "complete_registrations", to: "complete_registrations#index"
  put "complete_registration", to: "complete_registrations#update"

  get "complete_developer_registrations", to: "complete_developer_registrations#index"
  put "complete_developer_registration", to: "complete_developer_registrations#update"

  resources :users do
    resources :products, only: :index
  end

  resources :product_synchronizations, only: :show, param: :user_id
end
