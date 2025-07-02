Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top'
  resources :posts, only: [:new, :create, :index, :show, :destroy, :edit, :update]
  resources :users, only: [:show, :destroy, :edit, :update]
  get "home/about" => "homes#about", as: "about"
  get '/search', to: 'searches#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
