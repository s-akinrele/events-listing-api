Rails.application.routes.draw do
  resources :events
  resources :bookings

  post 'auth/login', to: 'authentication#authenticate'
  post 'signup', to: 'users#create'
end
