Rails.application.routes.draw do
  root "home#index"
  
  devise_for :users, controllers: { registrations: 'users/registrations' }
  resources :projects
  
  get 'choice', to: 'home#choice'
  get 'terms', to: 'home#terms'
   get 'perfil', to: 'users#perfil', as: 'perfil'
end
