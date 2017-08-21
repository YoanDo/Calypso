Rails.application.routes.draw do
  devise_for :users
  root to: 'pages#home'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resources :trips, only: [ :index, :show, :new, :create, :edit, :update ] do
    resources :comments, only: [:create]
    resources :participants, only: [ :create, :update ]

  end

  resources :users, only: [ :edit, :update, :show ] do
    get 'mytrips', on: :collection
    get 'mybookings', on: :collection
  end

end
