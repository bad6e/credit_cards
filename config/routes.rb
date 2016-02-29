Rails.application.routes.draw do
  namespace :admin do
    get 'imports/index'
  end

  namespace :admin do
    get 'imports/import'
  end

  root "welcome#index"
  get 'about', to: 'about#index'
  get 'blog', to: 'blog#index'

  resources :cards, only: [:index, :show]
  resources :categories, only: [:index, :show]

  get '/admin-login', to: 'sessions#new'
  post '/admin-login', to: 'sessions#create'
  get '/admin-logout', to: 'sessions#delete'
  delete "/admin-logout", to: "sessions#destroy"

  namespace "admin" do
    resources :cards, only: [:new, :create, :edit, :update, :index]
    resources :rewards, only: [:new, :create, :edit, :update, :index, :destroy]
    resources :imports do
      collection { post :import}
    end
  end

  namespace :api do
    namespace :v1, defaults: {format: :json} do
      get "/search", to: 'auto_complete#search'
      resources :rewards, only: [:show]
    end
  end
end
