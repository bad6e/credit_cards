require 'rails_helper'

RSpec.describe Card, type: :model do
  let(:category_one) {
    Category.create(name: "airline-credit-cards",
                    slug: "airline-credit-cards")
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

  it "returns a card object" do
    expect(CardPresenter.new(card_one.id).card.name).to eq("Southwest Airlines Premier")
    expect(CardPresenter.new(card_one.id).card).to be_a(Card)
  end

  it "returns four featured cards belonging to a specific category" do
    set_category
    expect(CardPresenter.new(card_one.id).featured_cards.count).to eq(4)
    expect(CardPresenter.new(card_one.id).featured_cards.first.categories.first.name).to eq("airline-credit-cards")
    expect(CardPresenter.new(card_one.id).featured_cards.first.categories.last.name).to eq("airline-credit-cards")
  end

  it "returns four featured cards and excludes the card searched" do
    set_category
    card_list = CardPresenter.new(card_one.id).featured_cards
    card_list.map {|card| card.name }
    expect(card_list.include?(card_one.name)).to eq(false)
  end

  it "returns the 'parsed category name' after receiving an 'unparsed category name" do
    category_name = CardPresenter.new(card_one.id).parse_category_name("airline-credit-cards")
    expect(category_name).to eq("Airline Credit Cards")
  end

  it "should return 2 random cards with the same category that have a reward associated with them - number of rewards do not matter" do
    set_category
    Reward.create(amount: 50000,
                  spending_amount: 3000,
                  record_date: "2016-02-18",
                  length_of_time: 3,
                  card_id: card_one.id)

    Reward.create(amount: 40000,
                  spending_amount: 3000,
                  record_date: "2016-02-11",
                  length_of_time: 3,
                  card_id: card_two.id)

    cards = CardPresenter.new(card_one.id).bonus_cards("airline-credit-cards")
    expect(cards.length).to eq(2)
  end

  it "returns the rewards associated with a specific card ordered by 'record date'" do
      Reward.create(amount: 50000,
                   spending_amount: 3000,
                   record_date: "2016-02-18",
                   length_of_time: 3,
                   card_id: card_one.id)

      Reward.create(amount: 40000,
                   spending_amount: 3000,
                   record_date: "2016-02-11",
                   length_of_time: 3,
                   card_id: card_one.id)

      Reward.create(amount: 30000,
                   spending_amount: 3000,
                   record_date: "2016-02-4",
                   length_of_time: 3,
                   card_id: card_one.id)

    expect(CardPresenter.new(card_one.id).rewards.count).to eq(3)
    expect(CardPresenter.new(card_one.id).rewards.first.amount).to eq(30000)
    expect(CardPresenter.new(card_one.id).rewards.last.amount).to eq(50000)
  end

  it "should reward TRUE if the card has a rewards associated with it" do
    Reward.create(amount: 50000,
                   spending_amount: 3000,
                   record_date: "2016-02-18",
                   length_of_time: 3,
                   card_id: card_one.id)

    expect(CardPresenter.new(card_one.id).card_has_bonus?).to eq(true)
  end

  it "should reward NIL if the card has a rewards associated with it" do
    expect(CardPresenter.new(card_one.id).card_has_bonus?).to eq(nil)
  end

  it "should return an array of all the categories for a specific card" do
    set_category
    expect(CardPresenter.new(card_one.id).category_list.class).to eq(Category::ActiveRecord_Associations_CollectionProxy)
    expect(CardPresenter.new(card_one.id).category_list.count).to eq(1)
    expect(CardPresenter.new(card_one.id).category_list.first.name).to eq("airline-credit-cards")
  end
end
