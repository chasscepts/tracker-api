Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations', sessions: 'authentication' },
    path: '/auth',
    path_names: { sign_in: '', sign_out: 'logout', registration: 'register' }

  resources :groups

  resources :tasks do
    member do
      get :entries
    end
  end

  resources :entries, only: [:index, :show, :update, :destroy]
end
