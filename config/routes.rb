Rails.application.routes.draw do
  root 'app#index'
  resources :tasks, only: [:index, :show, :create, :update, :destroy]
  resources :subtasks, only: [:show, :create, :update, :destroy]
end
