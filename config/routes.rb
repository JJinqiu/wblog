WBlog::Application.routes.draw do

  resources :blogs, :only=>[:index, :show, :edit] do
    collection do
      get :rss
      get :unexist
    end
    resources :comments, only: [:index, :create] do
      collection do
        get :refresh
      end
    end
    resources :likes, only: [:index, :create, :destroy] do
      member do
        get :is_liked
      end
    end
  end

  resources :archives do
    collection do
      get :regex_err
    end
  end
  resources :subscribes, only: [:index, :new, :create]

  resources :unsubscribes, only: [:index, :new, :create]
  # photos
  resources :photos, only: [:create]
  get '/qrcodes' => 'qrcodes#show'

  namespace :admin do
    resources :posts, except: [:show] do
      collection do
        post :preview
      end
      resources :comments
    end
    resources :sessions, :only=>[:new, :create, :destroy]
    resources :subscribes, only: [:index] do
      member do
        post :enable
        post :disable
      end
    end
    root 'dashboard#index'
  end

  get '/about' => 'home#index'
  get '/mobile' => 'home#mobile'
  get '/haskell' => 'haskell#index'  
  get 'haskell/index'
  get 'reward/index' 
  get '/reward' => 'reward#index'

  root 'blogs#index'

  mount ActionCable.server => '/cable'
end
