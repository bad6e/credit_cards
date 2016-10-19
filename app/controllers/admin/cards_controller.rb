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
    selected_categories   = card_params[:categories]
    selected_card_program = card_params[:card_program]
    @card = Card.new(card_params.except(:categories, :card_program))
    if @card.save
      assign_categories_to_card(selected_categories)
      assign_card_program_to_card(selected_card_program)
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
    selected_card_program      = card_params[:card_program]
    selected_main_card_program = card_params[:main_program]
    if @card.update(card_params.except(:categories, :card_program, :main_program))
      assign_categories_to_card(selected_categories)
      assign_main_card_program_to_card(selected_main_card_program)
      assign_card_program_to_card(selected_card_program)
      flash[:success] = "Card successfully updated!"
      redirect_to edit_admin_card_path(@card)
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

    def assign_main_card_program_to_card(selected_main_card_program)
      if selected_main_card_program.length > 1 && selected_main_card_program[0] == ""
        @card.update(main_program_id: MainProgram.find(selected_main_card_program[-1]).id)
      end
    end


    def assign_card_program_to_card(selected_card_program)
      if @card.card_program === nil

        selected_card_program.each do |id|
          if id != ""
            @card.update(card_program_id: CardProgram.find(id).id)
          end
        end

      else

        selected_card_program.each do |id|
          if id != "" && card_not_already_assigned_card_program(id)
            @card.update(card_program_id: CardProgram.find(id).id)
          end
        end

      end
    end

    def card_not_already_assigned(id)
      @card.categories.include?(Category.find(id))
    end

    def card_not_already_assigned_card_program(id)
      @card.card_program != CardProgram.find(id)
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
                                   :point_type,
                                   :categories => [],
                                   :main_program => [],
                                   :card_program => [],
                                   :information => [])
    end
end
