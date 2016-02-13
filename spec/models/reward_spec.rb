require 'rails_helper'

RSpec.describe Reward, type: :model do
  let(:reward_one) {
    Reward.create(amount: 50000,
                  spending_amount: 3000,
                  record_date: "2016-02-18",
                  length_of_time: 3)
  }

  it "is valid" do
    expect(reward_one).to be_valid
  end

  it "is invalid without an amount" do
    reward_one.amount = nil
    expect(reward_one).to be_invalid
  end

   it "is invalid without a spending amount" do
    reward_one.spending_amount = nil
    expect(reward_one).to be_invalid
  end

  it "is invalid without a record date" do
    reward_one.record_date = nil
    expect(reward_one).to be_invalid
  end

  it "is invalid without length of time for the bonus" do
    reward_one.length_of_time = nil
    expect(reward_one).to be_invalid
  end
end
