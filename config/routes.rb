Rails.application.routes.draw do

  namespace :admin do
    get 'imports/import'
  end

  get '/sitemap.xml.gz', to: redirect("https://#{ENV['S3_BUCKET_NAME']}.s3.amazonaws.com/sitemaps/sitemap.xml.gz"), as: :sitemap

  root "welcome#index"
  get '/admin-login', to: 'sessions#new'
  post '/admin-login', to: 'sessions#create'
  get '/admin-logout', to: 'sessions#delete'
  delete "/admin-logout", to: "sessions#destroy"

  resources :cards, only: [:index, :show]

  resources :categories, only: [:index]
  get "categories/:id", to: redirect("/%{id}")
  resources :categories, path: "", only: [:show]

  namespace :admin do
    get 'imports/index'
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
