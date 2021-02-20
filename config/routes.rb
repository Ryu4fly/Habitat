Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  root to: 'pages#home'

  get "profile", to: "pages#profile", as: :profile

  resources :entries, only: [:index, :show, :new, :create, :delete]
  resources :habits, only: [:new, :create]
end
