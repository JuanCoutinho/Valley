Rails.application.routes.draw do
  devise_for :users
  resources :projects
  
  root "home#index"
  get 'choice', to: 'home#choice'
  get 'terms', to: 'home#terms'
end
