class Admin::RewardsController < Admin::BaseController
  before_action :load_reward, only: [:edit, :update, :destroy]
  before_action :no_index_no_follow, only: [:new, :edit]

  def new
    @reward         = Reward.new
    card            = Card.find(params[:id])
    @card_name      = card.name
    @card_id        = card.id
    @last_reward    = card.rewards.order(record_date: :desc).last
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
    if @reward.update(reward_params)
      flash[:success] = "Reward successfully updated!"
      redirect_to edit_admin_card_path(reward_params[:card_id])
    else
      flash.now[:errors] = @reward.errors.full_messages.join(", ")
      render :edit
    end
  end

  def destroy
    card_id = @reward.card_id
    @reward.delete
    flash[:success] = "Reward successfully deleted!"
    redirect_to edit_admin_card_path(card_id)
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
