class Api::V1::RewardsController < ApplicationController
  respond_to :json

  def show
    sleep(1)
    respond_with Reward.where(card_id: params[:id]).order(record_date: 'desc')
  end
end
