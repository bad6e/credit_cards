class Admin::CardsController < Admin::BaseController
  before_action :load_card, only: [:show, :edit, :update, :destroy]

  def index
    @cards = Card.all
  end

  def show
  end

  def new
    @card = Card.new
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

    def card_params
      params.require(:card).permit(:name,
                                   :annual_fee,
                                   :information,
                                   :apr,
                                   :intro_rate,
                                   :image_link)
    end

    def load_card
      @card = Card.find(params[:id])
    end
end
