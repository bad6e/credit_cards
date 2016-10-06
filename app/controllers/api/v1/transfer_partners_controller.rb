class Api::V1::TransferPartnersController < ApplicationController
  respond_to :json
  before_action :verify_card_exists, only: [:show]

  def show
    respond_with find_card.transfer_partners
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

    def transfer_partner_params
      params.permit(:id)
    end
end