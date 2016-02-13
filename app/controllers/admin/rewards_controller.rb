class Admin::RewardsController < ApplicationController

  def new
    @reward         = Reward.new
    @card_name      = Card.find(params[:id]).name
    @card_id        = Card.find(params[:id]).id
    @reward.card_id = @card_id
  end

  def create
    @reward = Reward.new(reward_params)
    if @reward.save
      redirect_to admin_cards_path
    else
      render :new
    end
  end

  private
    def reward_params
      params.require(:reward).permit(:amount,
                                     :spending_amount,
                                     :record_date,
                                     :card_id)
    end
end
