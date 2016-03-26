require 'rails_helper'

RSpec.describe Api::V1::RewardsController, type: :controller do
  include_context "features"

  describe "GET /api/v1/rewards/:id" do
    it "returns all the rewards associated with a card in DESC order" do
      Reward.create(amount: 50000,
                length_of_time: 2,
                record_date: "2016-02-10",
                spending_amount: 2000,
                apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                card_id: card_five.id)

      Reward.create(amount: 48000,
                length_of_time: 2,
                record_date: "2016-02-22",
                spending_amount: 2000,
                apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                card_id: card_five.id)

      Reward.create(amount: 48000,
                length_of_time: 2,
                record_date: "2016-02-08",
                spending_amount: 2000,
                apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                card_id: card_five.id)

      Reward.create(amount: 48000,
                length_of_time: 2,
                record_date: "2016-02-25",
                spending_amount: 2000,
                apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                card_id: card_five.id)

      set_card_categories
      get :show, id: card_five.id, format: :json
      expect(response_data.length).to eq(2)
      expect(response_data['rewards'].length).to eq(4)
      expect(response_data['currency']).to eq("Barclay Miles")
      expect(response_data['rewards'].first["record_date"]).to eq("2016-02-25")
      expect(response_data['rewards'].last["record_date"]).to eq("2016-02-08")
    end
  end
end