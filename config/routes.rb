Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'boards#index'
  resources :boards do
    resources :tasks
  end

  namespace :api, defaults: { format: 'json'} do
    namespace :v1 do
      resources :boards, only: %i() do
        resources :tasks, only: %i() do
          resources :comments, only: %i(index create destroy), shallow: true
        end
      end
      resources :tasks, only: %i() do
        resource :status, only: %i(update), module: :tasks
      end
    end
  end
end
