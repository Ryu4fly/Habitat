Rails.application.routes.draw do
  get 'errors/not_found'
  get 'errors/internal_server_error'
  get 'users/update'
  devise_for :users, controllers: {registrations: "registrations"}
  root to: 'pages#home'

  get "profile", to: "pages#profile", as: :profile
  get "stats", to: "entries#my_stats", as: :my_stats
  get "race-dashboard", to: "races#race_dashboard", as: :race_dashboard
  put "update-balance", to: "races#update_balance", as: :update_balance
  get "claim-bets", to: "bets#claim_bets", as: :claim_bets
  get "game", to: "pages#game", as: :game

  match "/404", to: "errors#not_found", via: :all
  match "/500", to: "errors#internal_server_error", via: :all

  resources :entries, only: [:index, :show, :new, :create, :destroy]
  resources :habits, only: [:new, :create]
  resources :races, shallow: true do
    resources :bets
  end
end
