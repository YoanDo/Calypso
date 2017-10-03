Rails.application.routes.draw do


  resources :subscribers
  mount ActionCable.server => '/cable'
  mount Facebook::Messenger::Server, at: 'bot'

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
    get 'mymessages', on: :collection
    patch 'updatefbmessenger', on: :collection
    resources :reviews, only: [ :create ]
  end
scope '(:locale)', locale: /fr|en/ do
  root to: 'pages#home'
end
end
