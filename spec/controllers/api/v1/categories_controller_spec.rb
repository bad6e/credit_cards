require 'rails_helper'

RSpec.describe Api::V1::CategoriesController, type: :controller do
  include_context "features"

  describe "GET /api/v1/categories/:id" do

    it "returns all the cards associated with a category using a category id" do
      set_card_categories
      get :show, id: category_one.id, format: :json
      expect(response_data.length).to eq(5)
      expect(response_data[0]["name"]).to eq("Southwest Airlines Rapid Rewards® Premier Credit Card")
    end

    it "returns all the cards associated with a category using a category name" do
      set_card_categories
      get :show, id: category_one.name, format: :json
      expect(response_data.length).to eq(5)
    end

    it "returns all the card's rewards in DESC order associated with a category using a category id" do
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
      get :show, id: category_one.name, format: :json
      expect(response_data[0]['rewards'].length).to eq(4)
      expect(response_data[0]['rewards'][0]['record_date']).to eq("2016-02-25")
      expect(response_data[0]['rewards'][-1]['record_date']).to eq("2016-02-08")
    end
  end
end
