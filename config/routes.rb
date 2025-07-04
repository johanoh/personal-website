Rails.application.routes.draw do
  get "blog/index"
  get "blog/show"
  get "projects/index"
  root "home#index"
  get "/about", to: "about#index"
  get "/contact", to: "contact#index"
  resources :projects, only: [ :index, :show ]
  post "/contact", to: "contact#create"

  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  resources :blog, only: [ :index, :show ], controller: "blog", param: :slug

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"
  if Rails.env.development?
    mount LetterOpenerWeb::Engine, at: "/letter_opener"
  end

  def admin_routes
    devise_for :admins, controllers: { sessions: "admins/sessions" }, path: "admin_auth"
    namespace :admin_panel do
      root to: "dashboard#index"
      resources :blog_posts, param: :slug do
        member do
          patch :toggle_publish
          patch :toggle_hidden
        end
      end
      resources :tags, only: [ :new, :create ]
    end
  end

  if Rails.env.test?
    admin_routes
  end

  if Rails.env.development? || Rails.env.production?
    constraints lambda { |req|
      Rails.configuration.admin_allowed_ips.any? { |ip| req.remote_ip.start_with?(ip) }
    } do
      admin_routes
    end
  end
end
