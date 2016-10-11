class Admin::MainProgramsController < ApplicationController
  before_action :load_main_program, only: [:edit, :update]

  def index
    @main_programs = MainProgram.all.order('created_at DESC')
  end

  def edit
  end

  def update
    selected_programs = main_program_params[:card_programs].reject!{|p| p == ""}
    if @main_program.update(main_program_params.except(:card_programs))
      assign_programs_to_main_programs(selected_programs)
      flash[:success] = "Main program successfully updated!"
      redirect_to edit_admin_main_program_path
    else
      flash.now[:errors] = main_program.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

    def assign_programs_to_main_programs(selected_programs)
      selected_programs.each do |id|
        if !program_not_already_assigned(id)
          @main_program.card_programs << CardProgram.find(id)
        end
      end
    end

    def program_not_already_assigned(id)
      @main_program.card_programs.include?(CardProgram.find(id))
    end

    def main_program_params
      params.require(:main_program).permit(:id,
                                           :name,
                                           :image_url,
                                           :card_programs => [])
    end

    def load_main_program
      @main_program ||= MainProgram.find(params[:id])
    end
end
