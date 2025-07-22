Rails.application.routes.draw do
  devise_for :admin, skip: [:registrations, :password], controllers: {
    sessions: 'admin/sessions'
  }

  namespace :admin do
    get 'dashboards', to: 'dashboards#index'
    resources :users, only: [:destroy]
    resources :groups, only: [:destroy]
    resources :post_comments, only: [:destroy]
  end

  devise_for :users

  root to: 'homes#top'

  resources :posts, only: [:new, :create, :index, :show, :destroy, :edit, :update] do
    resource :favorite, only: [:create, :destroy]
    resources :post_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :destroy, :edit, :update]

  get "home/about" => "homes#about", as: "about"

  resources :groups, only: [:new, :index, :show, :create, :edit, :update] do
    resource :group_users, only: [:create, :destroy] do
      member do
        patch :approve
        patch :reject
      end
    end
    resources :event_notices, only: [:new, :create]
    get "event_notices" => "event_notices#sent"
  end

  devise_scope :user do
    post "users/guest_sign_in", to: "users/sessions#guest_sign_in"
  end

  resource :map, only: [:show]

  get '/search', to: 'searches#search'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
