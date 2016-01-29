Rails.application.routes.draw do
  root "welcome#index"

  namespace :api do
    namespace :v1, defaults: {format: :json} do
      get "/search", to: 'auto_complete#search'
    end
  end
end
