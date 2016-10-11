class Admin::TransferPartnersController < ApplicationController
  before_action :load_transfer_partner, only: [:edit, :update]

  def index
    @transfer_partners = TransferPartner.all.order('created_at DESC')
  end

  def edit
  end

  def update
    if @transfer_partner.update(transfer_partner_params)
      flash[:success] = "Transfer Partner Updated!"
      redirect_to edit_admin_transfer_partner_path
    else
      flash.now[:errors] = @transfer_partner.errors.full_messages.join(", ")
      render :edit
    end
  end

  private

    def transfer_partner_params
      params.require(:transfer_partner).permit(:id,
                                               :name,
                                               :image_url)
    end

    def load_transfer_partner
      @transfer_partner ||= TransferPartner.find(params[:id])
    end
end
