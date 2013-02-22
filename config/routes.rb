MailgunExample::Application.routes.draw do
  get "register", to: "users#new"
  get "sign_in", to: "sessions#new"
  post "login", to: "sessions#create", as: "login"
  get "sign_out", to: "sessions#destroy"

  resources :users, only: [:create]

  root to: "sessions#new"
end
