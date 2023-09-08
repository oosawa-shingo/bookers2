Rails.application.routes.draw do
  devise_for :users
  resources :books
  resources :users
  root to: "homes#top"
  get '/home/about' => "homes#about", as:"about"
end
