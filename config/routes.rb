Rails.application.routes.draw do
  resources :events

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
