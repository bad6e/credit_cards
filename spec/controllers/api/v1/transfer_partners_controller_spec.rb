require 'rails_helper'

RSpec.describe Api::V1::TransferPartnersController, type: :controller do
  describe "GET /api/v1/transfer_partners/:id" do
    context "the card_id is valid" do
      let!(:card_program)      { create(:card_program) }
      let!(:card_one)          { create(:card,
                                        card_program_id: card_program.id)
                               }

      let!(:transfer_partner1) { create(:transfer_partner) }
      let!(:transfer_partner2) { create(:transfer_partner) }
      let!(:transfer_partner3) { create(:transfer_partner) }
      let!(:transfer_partner4) { create(:transfer_partner) }

      let!(:ctp_1) { create(:card_program_transfer_partner,
                            card_program_id: card_program.id,
                            transfer_partner_id: transfer_partner1.id
                           )
      }

      let!(:ctp_2) { create(:card_program_transfer_partner,
                            card_program_id: card_program.id,
                            transfer_partner_id: transfer_partner2.id
                           )
      }

      let!(:ctp_3) { create(:card_program_transfer_partner,
                            card_program_id: card_program.id,
                            transfer_partner_id: transfer_partner3.id
                           )
      }

      let!(:ctp_4) { create(:card_program_transfer_partner,
                            card_program_id: card_program.id,
                            transfer_partner_id: transfer_partner4.id
                           )
      }

      before(:each) do
        get :show, id: card_one.id, format: :json
      end

      it { should respond_with 200 }

      it "returns the card program associated with the card" do
        expect(response_data.first.dig("name")).to eq(card_program.name)
        expect(response_data.first.dig("image_url")).to eq(card_program.image_url)
      end

      it "returns the transfer partners associated with the card program" do
        expect(response_data.first.dig("transfer_partners").length).to eq(4)
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
