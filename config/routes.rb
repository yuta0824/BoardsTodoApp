Rails.application.routes.draw do
  devise_for :users, controllers: { registrations: 'registrations' }
  root to: 'boards#index'
  resources :boards do
    resources :tasks do
      resources :comments, shallow: true
    end
  end
end
