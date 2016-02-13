class Admin::CardsController < Admin::BaseController
  before_action :load_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = Card.all
  end

  def show
  end

  def new
    @card = Card.new
    @card.categories.build
  end

  def create
    @card = Card.new(card_params)
    if @card.save
      redirect_to admin_cards_path
    else
      render :new
    end
  end

  def edit
    @card.categories.build
    @card_rewards = CardPresenter.new(@card.id)
  end

  def update
    if @card.update(card_params)
      redirect_to admin_cards_path
    else
      render :edit
    end
  end

  def destroy
    @card.delete
    redirect_to admin_cards_path
  end

  private

    def load_card
      @card = Card.find(params[:id])
    end

    def card_params
      params.require(:card).permit(:name,
                                   :annual_fee,
                                   :information,
                                   :apr,
                                   :intro_rate,
                                   :image_link,
                                   categories_attributes: [:id, :name, :slug, :_destroy],
                                   rewards_attributes: [:id, :amount, :spending_amount, :record_date])
    end
end
