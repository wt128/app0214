Rails.application.routes.draw do
get '/signup', to: 'users#new'


root 'static#home'
get '/home', to: 'static#home'
get '/help', to: 'static#help' 
get '/about', to: 'static#about'
get '/contact',to: 'static#contact'
get '/login', to: 'static#login'
post 'static/login'
delete 'static/login'
resources :users
get '/application/hello', to: 'application#hello'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
