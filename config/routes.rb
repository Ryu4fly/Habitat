Rails.application.routes.draw do
  devise_for :users, controllers: {registrations: "registrations"}
  root to: 'pages#home'

  get "profile", to: "pages#profile", as: :profile

  resources :entries, only: [:index, :show, :new, :create, :destroy]
  resources :habits, only: [:new, :create]
  resources :races, shallow: true do
    resources :bets
  end
end
