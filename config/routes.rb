Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  # ---------- DEFINITION DES ROUTES ----------
  get "menu" => "pages#menu", as: :menu

  resources :profiles, only: [:new, :create, :show, :edit, :update, :index]

  resources :participations, only: [:index, :show, :update, :create] do
    collection do
      get :available
    end
    member do
      get :replacement
      get :map
      patch :take
      post :unavailable_for_replacement
    end
    resources :reports, only: [:new, :create]
  end

  resources :unavailabilities, only: [:new, :create]

end
