Rails.application.routes.draw do
  root 'app#index'
  resources :tasks, only: [:index]
end
