Rails.application.routes.draw do
  resources :groups

  resources :tasks do
    member do
      get :entries
    end
  end

  resources :entries, only: [:index, :show, :update, :destroy]
end
