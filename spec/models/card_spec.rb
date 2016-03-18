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

  let(:card_three) {
    Card.create(name: "Barclays Arrival +",
                annual_fee: "$59",
                information: ["Bullet C", "Bullet D"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "www.test-plus.com")
  }



  let(:category_one) {
    Category.create(name: "cash-back-credit-cards",
                    slug: "cash-back-credit-cards")
  }

  let(:category_two) {
    Category.create(name: "airline-credit-cards",
                    slug: "airline-credit-cards")
  }

  let(:category_three) {
    Category.create(name: "travel-credit-cards",
                    slug: "travel-credit-cards")
  }


  def add_card_to_category
    card = Card.find(card_one.id)
    card.categories << Category.find(category_one.id)
    card.categories << Category.find(category_two.id)
    card.categories << Category.find(category_three.id)

    card = Card.find(card_two.id)
    card.categories << Category.find(category_one.id)
    card.categories << Category.find(category_two.id)
  end

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

  it "should return cards that belong to at least two specific categories" do
    add_card_to_category
    cards = Card.find_cards_that_are_in_multiple_categories(["airline-credit-cards", "cash-back-credit-cards"])
    expect(cards.count).to eq(2)
  end

  it "should return cards that belong to at least three specific categories - 3 categories" do
    add_card_to_category
    cards = Card.find_cards_that_are_in_multiple_categories(["airline-credit-cards", "cash-back-credit-cards", "travel-credit-cards"])
    expect(cards.count).to eq(1)
  end

   it "should return cards that belong to at least one specific categories" do
    add_card_to_category
    cards = Card.find_cards_that_are_in_multiple_categories(["airline-credit-cards"])
    expect(cards.count).to eq(2)
  end

  it "should parse the cards category name correctly and return it in array" do
    add_card_to_category
    expect(card_one.parse_card_categories_name.include?("Cash Back Credit Cards")).to eq(true)
    expect(card_one.parse_card_categories_name.include?("Airline Credit Cards")).to eq(true)
    expect(card_one.parse_card_categories_name.include?("Travel Credit Cards")).to eq(true)
  end

  it "should search and return all cards for a given search feature" do
    card_one
    card_two
    card_three
    search = Card.search("South")
    expect(search.count).to eq(2)
  end

  it "should search and return zero cards for a search for a card that doesn't exist" do
    card_one
    card_two
    card_three
    search = Card.search("Hi Mom")
    expect(search.count).to eq(0)
  end
end
