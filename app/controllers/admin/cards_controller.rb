class Admin::CardsController < Admin::BaseController
  before_action :load_card, only: [:show, :edit, :update, :destroy]
  before_action :load_presenter, only: [:edit, :update]

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
      flash[:success] = "Card successfully added!"
      redirect_to admin_cards_path
    else
      flash.now[:errors] = @card.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
    @card.categories.build
  end

  def update
    if @card.update(card_params)
      flash[:success] = "Card successfully updated!"
      redirect_to admin_cards_path
    else
      flash.now[:errors] = @card.errors.full_messages.join(", ")
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

    def load_presenter
      @card_rewards = CardPresenter.new(@card.id)
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
