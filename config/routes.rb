Rails.application.routes.draw do
  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :trips, only: [ :index, :show, :new, :create, :edit, :update ] do
    resources :comments, only: [:create]
    resources :participants, only: [ :create, :update ]
  end

  resources :users, only: [ :edit, :update, :show ] do
    get 'mytrips', on: :collection
    get 'mybookings', on: :collection
    get 'dashboard', on: :collection
  end

  root to: 'pages#home'
end
