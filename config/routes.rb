Rails.application.routes.draw do
  devise_for :users,
    controllers: { registrations: 'registrations', sessions: 'authentication' },
    path: '/auth',
    path_names: { sign_in: '', sign_out: 'logout', registration: 'register' }

  resources :groups, only: [:index, :show] do
    resources :tasks, only: [:create]
  end

  resources :tasks, only: [:update, :delete, :show, :index, :destroy]

  resources :entries, only: [:update, :destroy]

  get '/groups/:group_id/tasks' => 'tasks#for_group'
end
