require 'rails_helper'

RSpec.describe Api::V1::TransferPartnersController, type: :controller do
  describe "GET //api/v1/transfer_partners/:id" do
    context "the card_id is valid" do
      before(:each) do
        card_one        = FactoryGirl.create(:card)
        card_program    = FactoryGirl.create(:card_program)
        card_one.update(card_program_id: card_program.id)

        @transfer_one   = FactoryGirl.create(:transfer_partner)
        transfer_two    = FactoryGirl.create(:transfer_partner)
        transfer_three  = FactoryGirl.create(:transfer_partner)
        @transfer_four  = FactoryGirl.create(:transfer_partner)

        ctp_one         = FactoryGirl.create(:card_program_transfer_partner,
                                            card_id: card_one.id,
                                            transfer_partner_id: @transfer_one.id)

        ctp_two         = FactoryGirl.create(:card_program_transfer_partner,
                                            card_id: card_one.id,
                                            transfer_partner_id: transfer_two.id)

        ctp_three      = FactoryGirl.create(:card_program_transfer_partner,
                                            card_id: card_one.id,
                                            transfer_partner_id: transfer_three.id)

        ctp_four       = FactoryGirl.create(:card_program_transfer_partner,
                                            card_id: card_one.id,
                                            transfer_partner_id: @transfer_four.id)

        get :show, id: card_one.id, format: :json
      end

      it { should respond_with 200 }

      it "returns all the cards transfer partners" do
        expect(response_data.length).to eq(4)
        expect(response_data.first.dig("id")).to eq(@transfer_one.id)
        expect(response_data.last.dig("id")).to eq(@transfer_four.id)
      end
    end

    context "the card_id is invalid" do
      before(:each) do
        get :show, id: 10000, format: :json
      end

      it { should respond_with 400 }

      it "returns card NOT found error" do
        expect(response_data["error"]).to eq("No card found.")
      end
    end
  end
end