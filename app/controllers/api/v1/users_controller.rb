class Api::V1::UsersController < ApplicationController
  respond_to :json

  def show
    if current_user
      respond_with current_user.cards
    end
  end
end
