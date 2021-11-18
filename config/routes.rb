Rails.application.routes.draw do
  root to: "pages#welcome"
  devise_for :users, controllers: {omniauth_callbacks: "users/omniauth_callbacks"}
  resources :entries, except: [:new]
end
