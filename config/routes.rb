Rails.application.routes.draw do
  # Defines the root path route ("/")
  # root "posts#index"
  root "posts#index"

  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
  }

  resources :posts do
    member do
      patch :pin
      patch :unpin
    end

    member do
      post :like
      delete :unlike
    end

    collection do
      get :pinned
      get :announcements
    end

    resources :comments do
      member do
        post :like
        delete :unlike
      end
    end
  end

  resources :uploaded_files, only: %i[index new create show destroy]
  resources :topics, only: %i[ new create edit update destroy]

  resources :users, only: %i[ edit update destroy] do
    member do
      get 'profile'
      post :subscribe
      delete :unsubscribe
    end
  end

  get "home/index"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  get "help" => "pages#help", as: :help

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/*
  get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker
  get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
end
