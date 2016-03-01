require 'rails_helper'

RSpec.describe Category, type: :model do
  let(:category_one) {
    Category.create(name: "airline-credit-cards")
  }

  it "is valid" do
    expect(category_one).to be_valid
  end

   it "is invalid without a name" do
    category_one.name = nil
    expect(category_one).to be_invalid
  end

  it "parses the category name correctly" do
    name = category_one.parse_category_name
    expect(name).to eq("Airline Credit Cards")
  end
end
