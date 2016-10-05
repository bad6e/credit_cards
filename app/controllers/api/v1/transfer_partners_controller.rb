class Api::V1::TransferPartnersController < ApplicationController
  respond_to :json
  before_action :find_card, only: [:show]

  def show
    respond_with find_card.transfer_partners
  end

  private

    def find_card
      Card.find(transfer_partner_params[:id])
    end

    def transfer_partner_params
      params.permit(:id)
    end
end
