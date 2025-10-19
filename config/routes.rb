Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'boards#index'
  resources :boards do
    resources :tasks do
      resources :comments, shallow: true
    end
  end

  namespace :api do
    namespace :v1 do
      resources :tasks, only: %i() do
        resource :status, only: %i(update), module: :tasks
      end
    end
  end
end
