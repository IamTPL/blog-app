Rails.application.routes.draw do
  root 'pages#home'
  resources :authors
  resources :articles
  get 'login', to: 'sessions#new'
  post 'login', to: 'sessions#create'
  delete 'logout', to: 'sessions#destroy'
end
