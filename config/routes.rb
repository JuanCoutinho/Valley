Rails.application.routes.draw do
  root "home#index"

  # Devise routes for user authentication
  devise_for :users, controllers: { registrations: 'users/registrations' }

  # Resourceful routes for projects
  resources :projects do
    post 'toggle_like', on: :member
    resources :comments, only: [:create, :destroy]
  end

  # Resourceful routes for notifications
  resources :notifications, only: [:index] do
    member do
      post 'mark_as_read'
    end
  end

  # config/routes.rb
resources :users do
  get 'autocomplete', on: :collection
end

  # Resourceful routes for chats and chat messages
  resources :chats, only: %i[index create show] do
    collection do
      get 'usuarios'      # route to list users
      get 'notification'  # route to notifications
    end
  end
  
  resources :chats, only: [:show, :create]

  
  resources :chat_messages, only: :create

  # Other routes
  resources :posts
  get 'creator', to: 'home#creator' 
  get 'termos', to: 'home#termos'
  get 'faq', to: 'home#faq'
  get 'perfil', to: 'users#perfil', as: 'perfil'
end
