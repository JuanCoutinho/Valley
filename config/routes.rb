Rails.application.routes.draw do
  get 'notifications/index'
  get 'notifications/mark_as_read'
  root "home#index"

  resources :projects do
    post 'toggle_like', on: :member
  end

  resources :notifications, only: [:index] do
    member do
      post 'mark_as_read'
    end
  end

  resources :projects do
    resources :comments, only: [:create, :destroy]
  end

  
  resources :chats, only: %i[index create show]
  resources :chat_messages, only: :create
  resources :posts
  resources :notifications, only: [:index]
  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'usuarios', to: 'chats#usuarios'
  get 'creator', to: 'home#creator' 
  get 'notification', to: 'chats#notification'
  get 'termos', to: 'home#termos'
  get 'perfil', to: 'users#perfil', as: 'perfil'
end
