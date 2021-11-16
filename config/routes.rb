Rails.application.routes.draw do
  root to: "entries#index"
  devise_for :users, controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  resources :entries, except: [:index, :new]
  get '/dashboard', to: 'pages#dashboard'
end
