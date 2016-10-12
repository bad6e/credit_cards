class Admin::CardProgramsController < Admin::BaseController
  before_action :load_card_program, only: [:edit, :update]
  before_action :format_transfer_partner_ids, only: [:create, :update]

  def index
    @card_programs = CardProgram.all.order('created_at DESC')
  end

  def new
    @card_program = CardProgram.new
  end

  def create
    @card_program = CardProgram.new(card_program_params.except(:transfer_partners))
    if @card_program.save
      assign_transfer_partners_to_card_programs(format_transfer_partner_ids)
      redirect_to admin_card_programs_path
    else
      flash.now[:errors] = @card_program.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
    if @card_program.update(card_program_params.except(:transfer_partners))
      assign_transfer_partners_to_card_programs(format_transfer_partner_ids)
      flash[:success] = "Card program successfully updated!"
      redirect_to edit_admin_card_program_path
    else
      flash.now[:errors] = @card_program.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

    def format_transfer_partner_ids
      @_selected_transfer_programs ||= card_program_params[:transfer_partners].reject!{|p| p == ""}
    end

    def assign_transfer_partners_to_card_programs(selected_programs)
      selected_programs.each do |id|
        transfer_partner = TransferPartner.find(id)
        if !program_not_already_assigned(transfer_partner)
          @card_program.transfer_partners << transfer_partner
        end
      end
    end

    def program_not_already_assigned(transfer_partner)
      @card_program.transfer_partners.include?(transfer_partner)
    end

    def card_program_params
      params.require(:card_program).permit(:id,
                                           :name,
                                           :image_url,
                                           transfer_partners: [])
    end

    def load_card_program
      @card_program ||= CardProgram.find(params[:id])
    end
end
