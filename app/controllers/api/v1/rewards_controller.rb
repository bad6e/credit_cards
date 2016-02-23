class Api::V1::RewardsController < ApplicationController
  respond_to :json

  def show
     respond_with Reward.where(card_id: params[:id])
  end
end
