class Api::V1::RewardsController < ApplicationController
  respond_to :json
  before_action :find_card, only: [:show, :show_one]

  def show
    sleep(1)
    rewards  = Reward.where(card_id: params[:id]).order(record_date: 'desc')
    currency = find_card.point_type
    response = {rewards: rewards, currency: currency}
    respond_with response
  end

  def show_one
    reward = Reward.where(card_id: params[:id]).order(record_date: 'desc').first
    currency = find_card.point_type
    best_offer = find_card.best_offer
    response = {reward: reward, currency: currency, best_offer: best_offer}
    respond_with response
  end

  private

    def find_card
      @_card ||= Card.find(params[:id])
    end
end
