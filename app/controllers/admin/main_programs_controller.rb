class Admin::MainProgramsController < Admin::BaseController
  before_action :load_main_program, only: [:edit, :update]
  before_action :format_card_programs_ids, only: [:create, :update]

  def index
    @main_programs = MainProgram.all.order('created_at DESC')
  end

  def new
    @main_program = MainProgram.new
  end

  def create
    @main_program = MainProgram.new(main_program_params.except(:card_programs))
    if @main_program.save
      assign_card_programs_to_main_programs(format_card_programs_ids)
      redirect_to admin_main_programs_path
    else
      flash.now[:errors] = main_program.errors.full_messages.join(", ")
      render :new
    end
  end

  def edit
  end

  def update
    if @main_program.update(main_program_params.except(:card_programs))
      assign_card_programs_to_main_programs(format_card_programs_ids)
      flash[:success] = "Main program successfully updated!"
      redirect_to admin_main_programs_path
    else
      flash.now[:errors] = main_program.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

    def format_card_programs_ids
      @_selected_card_programs ||= main_program_params[:card_programs].reject!{|p| p == ""}
    end

    def assign_card_programs_to_main_programs(selected_card_programs)
      selected_card_programs.each do |id|
        card_program = CardProgram.find(id)
        if !program_not_already_assigned(card_program)
          @main_program.card_programs << card_program
        end
      end
    end

    def program_not_already_assigned(card_program)
      @main_program.card_programs.include?(card_program)
    end


    def main_program_params
      params.require(:main_program).permit(:id,
                                           :name,
                                           :image_url,
                                           card_programs: [])
    end

    def load_main_program
      @main_program ||= MainProgram.find(params[:id])
    end
end
