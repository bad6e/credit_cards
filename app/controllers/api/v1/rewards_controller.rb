class Api::V1::RewardsController < ApplicationController
  respond_to :json

  def show
    sleep(1)
    @records = Reward.where(card_id: params[:id]).order(record_date: 'desc')
    @currency = Card.find(card_id: params[:id]).reward_program
    @response = {:records => @records, :currency => @currency}
    
    respond_with @response
  end
end
