Rails.application.routes.draw do
  root "homes#top"
  get 'home/about' => "homes#about", as: "about"

  devise_for :users
  resources :users, only: [:show, :index, :edit, :update] do
    resource :relationships, only: [:create, :destroy]
    get "followers" => "relationships#followers", as: "followers"
    get "following" => "relationships#following", as: "following"
  end

  get "search", to: "searches#search"

  resources :books, only: [:show, :index, :create, :edit, :update, :destroy] do
    resources :book_comments, only: [:create, :destroy]
    resource :favorites, only: [:create, :destroy]
  end
end
