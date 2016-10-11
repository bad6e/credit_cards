class Admin::CardsController < Admin::BaseController
  before_action :load_card, only: [:show, :edit, :update, :destroy]
  before_action :load_presenter, only: [:edit, :update]
  before_filter :format_card_information, only: [:create, :update]
  before_action :no_index_no_follow, only: [:index, :new, :edit]

  def index
    no_index_no_follow
    @cards = Card.all
    @users = User.all
  end

  def show
  end

  def new
    @card = Card.new
  end

  def create
    selected_categories = card_params[:categories]
    selected_transfer_partners = card_params[:transfer_partners]
    @card = Card.new(card_params.except(:categories, :transfer_partners))
    if @card.save
      assign_categories_to_card(selected_categories)
      assign_card_program_to_cards(selected_transfer_partners)
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
    selected_categories        = card_params[:categories]
    selected_transfer_partners = card_params[:transfer_partners]
    if @card.update(card_params.except(:categories, :transfer_partners))
      assign_categories_to_card(selected_categories)
      assign_transfer_partners_to_cards(selected_transfer_partners)
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

    def format_card_information
      convert_form_information_to_sentences(params)
    end

    def convert_form_information_to_sentences(params)
      split_params                = params[:card][:information].split(". ")
      last_element_formatted      = split_params[-1].gsub(".", "")
      split_params.pop
      formatted_information       = split_params.insert(-1, last_element_formatted)
      params[:card][:information] = formatted_information.map! {|info| "#{info}." }
    end

    def assign_categories_to_card(selected_categories)
      selected_categories.each do |id|
        if ((id != "") and (card_not_already_assigned(id) == false))
          category = Category.find(id)
          @card.categories << category
        end
      end
    end

    def assign_transfer_partners_to_cards(selected_transfer_partners)
      selected_transfer_partners.each do |id|
        if ((id != "") and (card_not_already_assigned_tp(id) == false))
          transfer_partner = TransferPartner.find(id)
          @card.transfer_partners << transfer_partner
        end
      end
    end

    def card_not_already_assigned(id)
      @card.categories.include?(Category.find(id))
    end

    def card_not_already_assigned_tp(id)
      @card.transfer_partners.include?(TransferPartner.find(id))
    end

    def card_params
      params.require(:card).permit(:name,
                                   :annual_fee,
                                   :apr,
                                   :intro_rate,
                                   :image_link,
                                   :best_offer,
                                   :flyer_talk_link,
                                   :image_url,
                                   :categories => [],
                                   :transfer_partners => [],
                                   :information => [])
    end
end
