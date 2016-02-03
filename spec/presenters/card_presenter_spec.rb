require 'rails_helper'

RSpec.describe Card, type: :model do
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

  let(:card_two) {
    Card.create(name: "Southwest Airlines Plus",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "www.test-plus.com")
  }


  let(:card_three) {
    Card.create(name: "Chase Preferred",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "www.test-chase.com")
  }

  let(:card_four) {
    Card.create(name: "Citi Thank You",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "www.test-thankyou.com")
  }

  let(:card_five) {
    Card.create(name: "Barclays World Travel",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "www.test-barclaystravel.com")
  }

  def set_category
    c1 = Card.find(card_one.id)
    c1.categories << Category.find(category_one.id)

    c2 = Card.find(card_two.id)
    c2.categories << Category.find(category_one.id)

    c3 = Card.find(card_three.id)
    c3.categories << Category.find(category_one.id)

    c4 = Card.find(card_four.id)
    c4.categories << Category.find(category_one.id)

    c5 = Card.find(card_five.id)
    c5.categories << Category.find(category_one.id)
  end

  it "returns the card" do
    expect(CardPresenter.new(card_one.id).card_name.name).to eq("Southwest Airlines Premier")
  end

  it "returns the category name" do
    set_category
    expect(CardPresenter.new(card_one.id).category_name).to eq("Airline")
  end

  it "returns four featured cards" do
    set_category
    expect(CardPresenter.new(card_one.id).featured_cards.count).to eq(4)
  end

  it "returns four featured cards and excludes the card searched" do
    set_category
    card_list = CardPresenter.new(card_one.id).featured_cards
    card_list.map {|card| card.name }
    expect(card_list.include?(card_one.name)).to eq(false)
  end
end
