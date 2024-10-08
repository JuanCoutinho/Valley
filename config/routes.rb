Rails.application.routes.draw do
  root "home#index"

  resources :projects do
    post 'toggle_like', on: :member
  end

  resources :chats, only: %i[index create show]
  resources :chat_messages, only: :create
  resources :posts

  devise_for :users, controllers: { registrations: 'users/registrations' }

  get 'usuarios', to: 'chats#usuarios'
  get 'creator', to: 'home#creator'
  get 'termos', to: 'home#termos'
  get 'perfil', to: 'users#perfil', as: 'perfil'
end
