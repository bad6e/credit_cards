class Admin::CardProgramsController < Admin::BaseController
  before_action :load_card_program, only: [:edit, :update]

  def index
    @card_programs = CardProgram.all.order('created_at DESC')
  end

  def edit
  end

  def update
    selected_transfer_partners = card_program_params[:transfer_partners].reject!{|p| p == ""}
    if @card_program.update(card_program_params.except(:transfer_partners))
      assign_transfer_partners_to_card_programs(selected_transfer_partners)
      flash[:success] = "Card program successfully updated!"
      redirect_to edit_admin_card_program_path
    else
      flash.now[:errors] = @card_program.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

    def assign_transfer_partners_to_card_programs(selected_programs)
      selected_programs.each do |id|
        if !program_not_already_assigned(id)
          @card_program.transfer_partners << TransferPartner.find(id)
        end
      end
    end

    def program_not_already_assigned(id)
      @card_program.transfer_partners.include?(TransferPartner.find(id))
    end

    def card_program_params
      params.require(:card_program).permit(:id,
                                           :name,
                                           :image_url,
                                           :transfer_partners => [])
    end

    def load_card_program
      @card_program ||= CardProgram.find(params[:id])
    end
end
