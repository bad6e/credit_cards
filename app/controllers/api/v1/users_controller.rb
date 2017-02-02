class Api::V1::UsersController < ApplicationController
  respond_to :json
  before_action :set_cache_headers!, only: [:show]
  before_action :find_current_user, only: [:show]

  def show
    cards = current_user.cards
    render json: cards,
                  adapter: :json, each_serializer: Api::V1::SearchSerializer,
                  meta: { favorite_card_ids: current_user_favorite_ids, search_term: 'fav' }
  end

  private

  def find_current_user
    unless current_user
      render json: {
        error: "Must be logged to see favorite cards",
        status: 400
      }
    end
  end
end
