MailgunExample::Application.routes.draw do
  get "register", to: "users#new"
  get "sign_in", to: "sessions#new"
  post "login", to: "sessions#create", as: "login"
  get "sign_out", to: "sessions#destroy"

  get "home", to: "static_pages#index"
  get "billing", to: "static_pages#billing"

  resources :users, only: [:create, :update, :edit]

  namespace "api" do
    resources :bounced_mails, only: [:create]
  end

  root to: "sessions#new"
end
