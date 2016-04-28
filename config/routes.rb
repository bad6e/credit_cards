Rails.application.routes.draw do
  delete '/logout', to: 'sessions#destroy'
  get '/auth/:provider/callback', to: 'sessions#create'
  get '/auth/failure', to: 'sessions#auth_failure'
  get '/admin-login', to: 'sessions#new'
  post '/admin-login', to: 'sessions#create_standard'
  get '/admin-logout', to: 'sessions#delete'
  delete "/admin-logout", to: "sessions#destroy"

  namespace :admin do
    get 'imports/import'
  end

  get '/sitemap.xml.gz', to: redirect("https://#{ENV['S3_BUCKET_NAME']}.s3.amazonaws.com/sitemaps/sitemap.xml.gz"), as: :sitemap
  root "welcome#index"

  get '/credit-card-beginners-guide', to: 'pages#start_here'
  get '/what-is-a-credit-score', to: 'pages#what_is_a_credit_score'
  get '/types-of-credit-cards', to: 'pages#types_of_credit_cards'
  get '/the-credit-card-game', to: 'pages#the_credit_card_game'

  resources :about, only: [:index]
  resources :users, only: [:show, :update, :edit, :destroy]
  resources :cards, only: [:index, :show]
  resources :blogs, only: [:index, :show]

  resources :categories, only: [:index]
  get "categories/:id", to: redirect("/%{id}")
  resources :categories, path: "", only: [:show]

  namespace :admin do
    get 'imports/index'
    resources :cards, only: [:new, :create, :edit, :update, :index]
    resources :rewards, only: [:new, :create, :edit, :update, :index, :destroy]
    resources :blogs
    resources :imports do
      collection { post :import}
    end
  end

  namespace :api do
    namespace :v1, defaults: {format: :json} do
      get "/search", to: 'auto_complete#search'
      resources :rewards, only: [:show]
      resources :categories, only: [:show]
      resources :favorite_cards
      resources :users, only: [:show]
      resources :cards, only: [:index]
      resources :blogs, only: [:index, :show]
      resources :related_blogs, only: [:show]
    end
  end
end