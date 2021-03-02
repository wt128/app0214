Rails.application.routes.draw do
  get 'sessions/new'
get '/signup', to: 'users#new'


root 'static#home'
get '/home', to: 'static#home'
get '/help', to: 'static#help' 
get '/about', to: 'static#about'
get '/contact',to: 'static#contact'
get '/signup', to: 'users#new'
post '/signup', to: 'users#create'
get '/login', to: 'sessions#new'
post '/login', to: 'sessions#create'
delete '/logout', to: 'sessions#destroy'
resources :users
resources :account_activations, only: [:edit]
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
