class Api::V1::TransferPartnersController < ApplicationController
  respond_to :json
  before_action :verify_card_exists, only: [:show]
  before_action :verify_card_has_programs, only: [:show]

  def show
    if find_card.main_program_id
      respond_with find_card.main_program.card_programs
    else
      respond_with [find_card.card_program]
    end
  end

  private

    def find_card
      @_card ||= Card.find_by(id: transfer_partner_params[:id])
    end

    def verify_card_exists
      if !find_card
        render status: 400, json: {
          error: "No card found."
        }.to_json
      end
    end

    def verify_card_has_programs
      if !find_card.main_program_id && !find_card.card_program_id
        render json: nil
      end
    end

    def transfer_partner_params
      params.permit(:id)
    end
end