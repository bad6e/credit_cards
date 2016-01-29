Rails.application.routes.draw do
  root "welcome#index"
  get 'about', to: 'about#index'


  resources :cards, only: [:show]

  namespace :api do
    namespace :v1, defaults: {format: :json} do
      get "/search", to: 'auto_complete#search'
    end
  end
end
