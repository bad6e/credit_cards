class Api::V1::RewardsController < ApplicationController
  respond_to :json

  def show
    sleep(1)
    rewards  = Reward.where(card_id: params[:id]).order(record_date: 'desc')
    currency = Card.find(params[:id]).point_type
    response = {:rewards => rewards, :currency => currency}
    respond_with response
  end
end
