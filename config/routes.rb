Rails.application.routes.draw do
get '/signup', to: 'users#new'


root 'static#home'
get '/home', to: 'static#home'
get '/help', to: 'static#help' 
get '/about', to: 'static#about'
get '/contact',to: 'static#contact'
get '/signup', to: 'users#new'
post '/signup', to: 'users#create'
delete 'static/login'
resources :users
get '/application/hello', to: 'application#hello'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
