require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:card_one) {
    Card.create(name: "Southwest Airlines Premier",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "www.test-premier.com")
  }

  let(:card_two) {
    Card.create(name: "Southwest Airlines Plus",
                annual_fee: "$59",
                information: ["Bullet C", "Bullet D"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "www.test-plus.com")
  }

  it "is valid" do
    expect(card_one).to be_valid
  end

  it "is invalid without a name" do
    card_one.name = nil
    expect(card_one).to be_invalid
  end

  it "is invalid without an annual fee" do
    card_one.annual_fee = nil
    expect(card_one).to be_invalid
  end

  it "is invalid without a card information" do
    card_one.information = nil
    expect(card_one).to be_invalid
  end

  it "is invalid without an apr rate" do
    card_one.apr = nil
    expect(card_one).to be_invalid
  end

  it "is invalid without an intro rate" do
    card_one.intro_rate = nil
    expect(card_one).to be_invalid
  end

  it "is invalid without an image url" do
    card_one.image_link = nil
    expect(card_one).to be_invalid
  end
end
