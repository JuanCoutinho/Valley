Rails.application.routes.draw do
  resources :posts

  root "home#index"

  resources :projects do
    post 'toggle_like', on: :member
  end

  devise_for :users, controllers: { registrations: 'users/registrations' }

  resources :chats, only: %i[index create show]
  resources :chat_messages, only: :create

  get 'usuarios', to: 'chats#usuarios'
  get 'creator', to: 'home#creator'
  get 'termos', to: 'home#termos'
  get 'perfil', to: 'users#perfil', as: 'perfil'
end
