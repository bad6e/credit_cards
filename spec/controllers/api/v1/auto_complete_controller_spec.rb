require 'rails_helper'

RSpec.describe Api::V1::AutoCompleteController, type: :controller do
  include_context "features"

  describe "GET /api/v1/search/:term" do
    it "returns the cards based on a searched name" do
      get :search, term: "South", format: :json
      expect(response_data.length).to eq(2)
      expect(response_data[0]['name']).to eq("Southwest Airlines Rapid Rewards® Premier Credit Card")
    end

    it "returns all the cards if no search term is provided" do
      get :search, term: "", format: :json
      expect(response_data.length).to eq(7)
    end
  end
end
