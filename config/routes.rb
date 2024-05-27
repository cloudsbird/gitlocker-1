Rails.application.routes.draw do
  if Rails.env.production?
    constraints(host: /^(?!www\.)/i) do
      match '(*any)', to: redirect { |params, request|
        URI.parse(request.url).tap { |uri| uri.host = "www.#{uri.host}" }.to_s
      }, via: :all
    end
  end

  devise_for :users, controllers: {
    registrations: "users/registrations",
    sessions: "users/sessions",
    omniauth_callbacks: "users/omniauth_callbacks",
    passwords: 'passwords'
  }
  devise_scope :user do
    get '/password_instructions', to: 'passwords#show_instructions'
    get '/signup_success', to: 'users/registrations#signup_success', as: 'signup_success'
  end

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  get "/sitemap.xml", to: redirect("https://s3.us-east-2.amazonaws.com/gitlocker/sitemaps/sitemap.xml", status: 301)

  # Defines the root path route ("/")
  root "home#index"

  get "privacy", to: "home#privacy"
  get "explore", to: "home#explore"
  get "terms", to: "home#terms"
  get "refund_policy", to: "home#refund_policy"
  get "contact", to: "home#contact"
  get "robots.txt", to: "home#robots"

  get "dashboard", to: "dashboard#index"
  get "seller_dashboard", to: "dashboard#seller_dashboard"

  get "complete_registrations", to: "complete_registrations#index"
  put "complete_registration", to: "complete_registrations#update"

  get "complete_developer_registrations", to: "complete_developer_registrations#index"
  put "complete_developer_registration", to: "complete_developer_registrations#update"

  resources :users, only: [:show, :edit, :update] do
    resources :products, only: :index, controller: "users/products"
    get :synchronizations, to: "users/synchronizations#show", on: :member
    put :product_activations, to: "users/product_activations#update", on: :member
  end

  resources :creators, only: [:index, :show]
  resources :purchases, only: [:index]
  resources :accounts
  resources :refunds, only: [:new, :create]

  resources :products, only: [:index, :show, :edit, :update,:new, :create, :destroy] do
    resources :covers, only: [:create, :destroy], controller: "product_covers"
    post 'like', on: :member
    post 'unlike', on: :member
  end

  resources :subscribed_users, only: :create
  resources :languages, only: :show, param: :slug
  resources :categories, only: :show, param: :slug

  resources :library, only: :show, path: "l" do
    resources :reviews, only: [:new, :create]
  end

  resources :cart_items, only: [:index, :create, :destroy]

  resources :sales, only: [:index, :show]
  resources :funds, only: [:index, :create]

  get "checkout", to: "checkout#index"
  post "checkout", to: "checkout#create"

  get "search", to: "search_results#index"

  get "browse", to: "browse#index"
  get "browse/popular", to: "browse#popular"
  get "browse/recent", to: "browse#recent"
  get "browse/languages", to: "browse#languages"
  get "browse/categories", to: "browse#categories"
  get '/success_payment', to: 'checkout#success_payment', as: 'success_payment'
  get '/cancel_payment', to: 'checkout#cancel_payment', as: 'cancel_payment'

  # Error Pages
  match '/404', to: 'errors#not_found', via: :all
  match '/422', to: 'errors#unacceptable', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all
end
