class Admin::RewardsController < ApplicationController
  before_action :load_reward, only: [:edit, :update]

  def new
    @reward         = Reward.new
    @card_name      = Card.find(params[:id]).name
    @card_id        = Card.find(params[:id]).id
    @reward.card_id = @card_id
  end

  def create
    @reward = Reward.new(reward_params)
    if @reward.save
      flash[:success] = "Reward successfully created!"
      redirect_to edit_admin_card_path(reward_params[:card_id])
    else
      flash.now[:errors] = @reward.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
    @reward = Reward.new(reward_params)
    if @reward.update(reward_params)
      flash[:success] = "Reward successfully updated!"
      redirect_to edit_admin_card_path(reward_params[:card_id])
    else
      flash.now[:errors] = @reward.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

    def load_reward
      @reward = Reward.find(params[:id])
    end

    def reward_params
      params.require(:reward).permit(:amount,
                                     :spending_amount,
                                     :record_date,
                                     :length_of_time,
                                     :card_id,
                                     :apply_link)
    end
end
