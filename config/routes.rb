Rails.application.routes.draw do
  root "projects#index"

  namespace :admin do
    root 'application#index'
  end

  resources :projects do
    resources :tickets
  end
end
