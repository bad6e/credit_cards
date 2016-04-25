class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :set_cache_headers!, only: [:show]

  def show
    if current_user
      respond_with current_user.cards
    else
      render json: {
        error: "Must be logged to create Store",
        status: 400
      }
    end
  end
end
