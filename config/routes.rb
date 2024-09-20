Rails.application.routes.draw do

  resources :projects do
    post 'toggle_like', on: :member
  end
  
  root "home#index"
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :projects
  
  resources :chats, only: %i[index create show]
  resources :chat_messages, only: :create

  get 'creator', to: 'home#creator'
  get 'termos', to: 'home#termos'
  get 'perfil', to: 'users#perfil', as: 'perfil'
end
