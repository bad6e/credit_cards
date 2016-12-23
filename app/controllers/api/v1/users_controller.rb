class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :set_cache_headers!, only: [:show]

  def show
    if current_user
      response = { cards: current_user.cards, search_term: 'fav'}
      render json: response, include: ['rewards']
    else
      render json: {
        error: "Must be logged to create Store",
        status: 400
      }
    end
  end
end
