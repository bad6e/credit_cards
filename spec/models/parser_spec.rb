require 'rails_helper'

RSpec.describe Reward, type: :model do
  include_context "features"

  let(:filename) {
    uploaded_file = ActionDispatch::Http::UploadedFile.new({
    :tempfile => File.new(Rails.root.to_s + "/spec/fixtures/card-test.csv")
    })
  }

  let(:date) {
    "2016-02-18"
  }

  let(:environment) {
    Rails.env
  }

  let(:card_table) {
    {"Arrival +" => "Barclaycard Arrival Plus™ World Elite MasterCard®",
      "Venture Rewards" => "Capital One® Venture® Rewards Credit Card",
      "Sapphire Preferred" => "Chase Sapphire Preferred® Card",
      "Southwest Premier" => "Southwest Airlines Rapid Rewards® Premier Credit Card",
      "Southwest Plus" => "Southwest Rapid Rewards® Plus Credit Card"
    }
  }

  let(:row) {
    rows = []
    CSV.foreach(filename.path, :headers => true, :header_converters => :symbol) do |row|
      rows << row
    end
    rows[32]
  }

  it "it calls the appropiate environment from the environment list" do
    parser = Parser.new
    parser.stubs(:check_if_card_exists).returns("You called the check if card exists method")
    response = parser.environment_list[environment].call
    expect(response).to eq("You called the check if card exists method")
  end

  it "checks if the card exists by finding the cards name" do
    parser = Parser.new
    parser.stubs(:find_card_name).returns("The card must exist - the 'find by name' was called")
    parser.stubs(:update_card_attributes).returns("The card must exist - the 'find by name' was called")
    parser.stubs(:create_card_rewards).returns("The card must exist - the 'find by name' was called")
    response = parser.check_if_card_exists(row, date, card_table)
    expect(response).to eq("The card must exist - the 'find by name' was called")
  end

  it "updates the cards attributes - specfically the flyer talk link and the best offer" do
    parser = Parser.new
    parser.update_card_attributes(card_five, row)
    expect(card_five.best_offer).to eq("Yes")
    expect(card_five.flyer_talk_link).to eq("http://www.flyertalk.com/forum/credit-card-programs/1577043-barclays-arrival-arrival-cards-1-1-2-2-travel-credits.html")
  end

  it "creates the card rewards for a specific card" do
    expect(card_five.rewards.count).to eq(0)
    parser = Parser.new
    parser.create_card_rewards(card_five, row, date)
    expect(card_five.rewards.count).to eq(1)
  end
end
