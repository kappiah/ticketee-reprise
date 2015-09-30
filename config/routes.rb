Rails.application.routes.draw do
  root "projects#index"

  namespace :admin do
    root 'application#index'

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

  resources :projects, only: [:index, :show, :edit, :update]  do
    resources :tickets
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
