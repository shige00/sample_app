Rails.application.routes.draw do
  resources :questions do
    resources :answers, :only => [:create, :destroy]
  end
  
  devise_for :users, :controllers => {
    :sessions      => "users/sessions",
    :registrations => "users/registrations",
    :passwords     => "users/passwords"
  } 

  resources :users, :only => [:show, :edit, :update]
  resources :movies do
    resources :comments, :only => [:create, :destroy]
  end
  resources :likes
  resources :nices
  resources :relationships, only: [:create, :destroy]

  get "/" => "home#top"

  get "/users/:id/follow" => "users#follow"
  get "/users/:id/follower" => "users#follower"

  post 'like/:id' => 'likes#create', as: 'create_like'
  delete 'like/:id' => 'likes#destroy', as: 'destroy_like'

  post 'nice/:id' => 'nices#create', as: 'create_nice'
  delete 'nice/:id' => 'nices#destroy', as: 'destroy_nice'

  get 'search' => 'movies#search'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
