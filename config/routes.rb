Bungaku::Application.routes.draw do
  devise_for :users
  devise_scope :user do
    get "/users/sign_in", to: 'devise/sessions#new', as: :new_user_session
    get "/users/sign_out", to: 'devise/sessions#destroy', as: :destroy_user_session
  end

  scope module: :home do
    resources :repositories, only: [:index]
    resources :text_repositories, only: [:index]
  end
  resources :followings, only:[:destroy]
  resources :users, only: [:show, :edit, :update, :destroy] do
    resources :repositories, only: [:index]
    resources :text_repositories, only: [:index, :new, :create]
    resources :followers, only: [:index]
    resources :followings, only:[:index, :create]
  end
  resources :text_repositories, only: [:show]
  resources :repositories, only: [:show, :new] do
    resources :branches, only: [:index]
  end
  resources :branches, only: [:show] do
    resources :kommits, only: [:index, :show] do
      resources :diffs, only: [:show]
    end
  end

  namespace :admin do
    resources :text_repositories, only: [:index, :show, :edit, :update]
    resources :repositories, only: [:index, :show, :edit, :update, :destroy]
    resources :branches, only: [:show, :destroy] do
      resource :merge, only: [:new, :create]
      resources :branches, only: [:new, :create], path: :checkout, as: :checkouts
      resources :kommits, only: [:index, :show, :new, :create, :destroy] do
        #resource :revert, only: [:create]
        resource :rollback, only: [:create]
        resources :files, only: [:index]
        get 'files/:name', to: "files#show", as: "file"
        put 'files/:name', to: "files#update", as: "file"
      end
      resources :posts, only: [:index, :create]
    end
    resources :posts, only: [:update, :destroy]
  end

  namespace :timeline do
    resources :feeds, only: [:index]
    resources :tweets, only: [:index]
    resources :news, only: [:index]
  end
  root to: "home#index"
end
