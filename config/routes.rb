Rails.application.routes.draw do

  mount ActionCable.server => '/cable'

  devise_for :users,
    controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :trips, only: [ :index, :show, :new, :create, :edit, :update ] do
    resources :comments, only: [:create]
    resources :participants, only: [ :create, :update ]
    resources :messages, only: [:create]
    get :cancel, on: :member
  end

  resources :users, only: [ :edit, :update, :show ] do
    get 'mytrips', on: :collection
    get 'mybookings', on: :collection
    get 'mymessages', on: :collection
    get 'dashboard', on: :collection
    resources :reviews, only: [ :create ]
  end

  root to: 'pages#home'
end
