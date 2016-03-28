require 'rails_helper'

RSpec.describe Reward, type: :model do
  let(:reward) {
    Reward.create(amount: 50000,
                  spending_amount: 3000,
                  record_date: "2016-02-17",
                  length_of_time: 3,
                  cent_value: 0.02)
  }

  it "is valid" do
    expect(reward).to be_valid
  end

  it "is invalid without an amount" do
    reward.amount = nil
    expect(reward).to be_invalid
  end

   it "is invalid without a spending amount" do
    reward.spending_amount = nil
    expect(reward).to be_invalid
  end

  it "is invalid without a record date" do
    reward.record_date = nil
    expect(reward).to be_invalid
  end

  it "is invalid without length of time for the bonus" do
    reward.length_of_time = nil
    expect(reward).to be_invalid
  end

  it "finds the previous reward's cent value and applies it to a new reward and updates dollar amount" do
    card_one = Card.create(name: "Southwest Airlines Rapid Rewards® Premier Credit Card",
               annual_fee: "$99",
               information: ["Bullet A", "Bullet B"],
               apr: "12%",
               intro_rate: "N/A",
               image_link: "https://www.google.com/?gws_rd=ssl",
               point_type: "Southwest Rapid Rewards®")

    reward_one = Reward.create(amount: 50000,
                 spending_amount: 3000,
                 record_date: "2016-02-17",
                 length_of_time: 3,
                 card_id: card_one.id,
                 cent_value: 0.02)

    reward_two = Reward.create(amount: 55000,
                 spending_amount: 3000,
                 record_date: "2016-02-18",
                 length_of_time: 3,
                 card_id: card_one.id)

    expect(reward_two.cent_value).to eq(0.02)
    expect(reward_two.dollar_amount).to eq(1100)
  end

  it "does not apply a cent value nor dollar_amount to a new reward if the previous cent value is nil" do
    card_one = Card.create(name: "Southwest Airlines Rapid Rewards® Premier Credit Card",
               annual_fee: "$99",
               information: ["Bullet A", "Bullet B"],
               apr: "12%",
               intro_rate: "N/A",
               image_link: "https://www.google.com/?gws_rd=ssl",
               point_type: "Southwest Rapid Rewards®")

    reward_one = Reward.create(amount: 50000,
                 spending_amount: 3000,
                 record_date: "2016-02-17",
                 length_of_time: 3,
                 card_id: card_one.id)

    reward_two = Reward.create(amount: 50000,
                 spending_amount: 3000,
                 record_date: "2016-02-18",
                 length_of_time: 3,
                 card_id: card_one.id)

    expect(reward_two.cent_value).to eq(nil)
    expect(reward_two.dollar_amount).to eq(nil)
  end

  it "does not apply a cent_value or dollar_amount to a new reward if reward is updated" do
    card_one = Card.create(name: "Southwest Airlines Rapid Rewards® Premier Credit Card",
               annual_fee: "$99",
               information: ["Bullet A", "Bullet B"],
               apr: "12%",
               intro_rate: "N/A",
               image_link: "https://www.google.com/?gws_rd=ssl",
               point_type: "Southwest Rapid Rewards®")

    reward_one = Reward.create(amount: 50000,
                 spending_amount: 3000,
                 record_date: "2016-02-17",
                 length_of_time: 3,
                 card_id: card_one.id,
                 cent_value: 0.02,
                 dollar_amount: 1000)

    reward_one.update(cent_value: 0.03)
    expect(reward_one.cent_value).to eq(0.03)
    # The dolalr amount is not calculated here - see note below:
    expect(reward_one.dollar_amount).to eq(1000)
  end

  # Currently there is no way to retroactively update a point value - all dollar_amounts are set in monthly valuations
  # If we need this function I shall build it in
end
