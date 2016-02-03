require 'rails_helper'

RSpec.describe Categorizing, type: :model do
  let(:category_one) {
    Category.create(name: "airline")
  }

  let(:card_one) {
    Card.create(name: "Southwest Airlines Premier",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "www.test-premier.com")
  }

  let(:categorizing_one) {
    Categorizing.create(category_id: category_one.id,
                        card_id: card_one.id)
  }

  it "is valid" do
    expect(categorizing_one).to be_valid
  end

  it "is invalid without a card id" do
    categorizing_one.card_id = nil
    expect(categorizing_one).to be_invalid
  end

  it "is invalid without a category id" do
    categorizing_one.category_id = nil
    expect(categorizing_one).to be_invalid
  end
end
