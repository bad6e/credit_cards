class Api::V1::FavoriteCardsController < ApplicationController
  respond_to :json
  before_action :load_card, only: [:update, :destroy]

  def show
    if current_user
      respond_with current_user.cards.map{|card| card.id}
    else
      render json: {
        error: "Must be logged in to receive ids",
        status: 400
      }
    end
  end

  def update
    if current_user
      check_card_like_status(@card)
    else
      render json: {
        error: "Must be logged in to favorite card",
        status: 400
      }
    end
  end

  def destroy
    if current_user
      current_user.cards.delete(@card)
      render json: {
        message: "Card Removed From Favorite List",
        status: 201
      }
    else
      render json: {
        error: "Must be logged in to unfavorite card",
        status: 400
      }
    end
  end

  private

  def check_card_like_status(card)
    if current_user.cards.include?(card)
      render json: {
        error: "Card Already Liked",
        status: 400
      }
    else
      assign_favorite_card_to_user(card)
    end
  end

  def assign_favorite_card_to_user(card)
    current_user.cards << card
    render json: {
      status: 201
    }
  end

  def load_card
    @card = Card.find(params[:id])
  end
end