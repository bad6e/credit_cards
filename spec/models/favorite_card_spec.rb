require 'rails_helper'

RSpec.describe FavoriteCard, type: :model do

  let(:user_one) {
    User.create(first_name: "Bret",
                last_name: "Doucette",
                email: "test@test.com",
                password: "password",
                name: "Bret Doucette",
                role: 1)
  }

  let(:card_one) {
    Card.create(name: "Southwest Airlines Premier",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "www.test-premier.com")
  }

  let(:favorite_cards_one) {
    FavoriteCard.create(user_id: user_one.id,
                        card_id: card_one.id)
  }

  it "is valid" do
    expect(favorite_cards_one).to be_valid
  end

  it "is invalid without a card id" do
    favorite_cards_one.card_id = nil
    expect(favorite_cards_one).to be_invalid
  end

  it "is invalid without a user id" do
    favorite_cards_one.user_id = nil
    expect(favorite_cards_one).to be_invalid
  end
end
