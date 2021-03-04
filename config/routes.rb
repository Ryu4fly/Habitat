Rails.application.routes.draw do
  get 'users/update'
  devise_for :users, controllers: {registrations: "registrations"}
  root to: 'pages#home'

  get "profile", to: "pages#profile", as: :profile
  get "stats", to: "entries#my_stats", as: :my_stats
  get "race-dashboard", to: "races#race_dashboard", as: :race_dashboard
  put "update-balance", to: "races#update_balance", as: :update_balance
  get "game", to: "pages#game", as: :game

  resources :entries, only: [:index, :show, :new, :create, :destroy]
  resources :habits, only: [:new, :create]
  resources :races, shallow: true do
    resources :bets
  end
end
