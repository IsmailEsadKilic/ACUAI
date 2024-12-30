Rails.application.routes.draw do
  root "posts#index"

  devise_for :users
  
  resources :users do
    member do
      get :profile
      post :subscribe
      delete :unsubscribe
    end
  end

  resources :posts do
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
    member do
      post :like
      delete :unlike
      post :pin
      delete :unpin
    end
  end

  resources :topics
  resources :uploaded_files
  resources :subscriptions, only: [:create, :destroy]

  get 'help', to: 'pages#help'
  post 'direct_uploads', to: 'direct_uploads#create'
end
