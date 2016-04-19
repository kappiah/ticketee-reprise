Rails.application.routes.draw do

  namespace :admin do
    root to: "application#index"

    resources :projects, only: [:new, :create, :destroy]
    resources :users do
      member do
        patch :archive
      end
    end

    resources :states, only: [:new, :create, :index] do
      member do
        get :make_default
      end
    end
  end

  root to: "projects#index"

  resources :projects, only: [:index, :show, :edit, :update]  do
    resources :tickets do
      collection do
        get :search
      end
      member do
        post :watch
      end
    end
  end

  resources :tickets, only: [] do
    resources :comments, only: [:create]
    resources :tags, only: [] do
      member do
        delete :remove
      end
    end
  end

  resources :attachments, only: [:show, :new]

end
