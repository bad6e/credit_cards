require 'rails_helper'
require "rspec/mocks/standalone"

RSpec.describe Reward, type: :model do
  include_context "features"

  let(:val) {
    MonthlyValuations.new("2016-02", "https://www.google.com/?gws_rd=ssl")
  }

  it "opens the html page" do
    expect(val.instance_variable_get("@page").children.first.name).to eq("table")
  end

  it "formats the month params correctly" do
    expect(val.format_month_params("2016-02")).to eq(2)
  end

  it "formats the year params correctly" do
    expect(val.format_year_params("2016-02")).to eq(2016)
  end

  it "finds the program names from the table" do
    expect(val.program_names.first).to eq("PROGRAM")
    expect(val.program_names.second).to eq("American Express Membership Rewards")
  end

  it "finds the cent values from the table" do
    expect(val.cent_values.first).to eq("March 2016 (cents)")
    expect(val.cent_values.second).to eq("1.9")
  end

  it "joins the program names with its corresponding cent value in a large hash" do
    expect(val.join_pc_values.first).to eq(["PROGRAM", "March 2016 (cents)"])
    expect(val.join_pc_values["American Express Membership Rewards"]).to eq("1.9")
  end

  it "formats a cent_value range into an array of floats" do
    expect(val.format_range_cent_values("1.2-3.0")).to eq([1.2, 3.0])
  end

  it "updates the program/cent_value hash to remove ranges" do
    expect(val.program_valuations["FlexPerks"]).to eq(1.665)
    expect(val.program_valuations["American Express Membership Rewards"]).to eq("1.9")
  end

  it "finds a card's rewards matching a specific date and month" do
    Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2016-02-18",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2016-02-11",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

     Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2016-03-18",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2015-02-11",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2015-02-11",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_two.id)


    Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2015-02-11",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_two.id)

    expect(val.find_card_rewards_with_specific_month_and_year(card_one).count).to eq(2)
  end

  it "it updates the rewards in the database with the correct month/year and the correct point value" do
    reward_one = Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2016-02-18",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    reward_two = Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2016-02-11",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    reward_three = Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2016-03-18",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    reward_four = Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2015-02-11",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    reward_five = Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2016-02-18",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_eight.id)

    reward_six = Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2016-02-11",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_eight.id)

    reward_seven = Reward.create(amount: 45000,
              length_of_time: 2,
              record_date: "2016-02-01",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_eight.id)

    reward_eight = Reward.create(amount: 40000,
              length_of_time: 2,
              record_date: "2015-02-11",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_eight.id)

    expect(reward_one.cent_value).to eq(nil)
    val.update_cards_rewards
    expect(card_one.rewards.first.cent_value).to eq(0.015)
    expect(card_one.rewards.second.cent_value).to eq(0.015)
    expect(card_one.rewards.third.cent_value).to eq(nil)
    expect(card_one.rewards.fourth.cent_value).to eq(nil)

    expect(card_eight.rewards.first.cent_value).to eq(0.017)
    expect(card_eight.rewards.first.amount).to eq(55000)

    expect(card_eight.rewards.second.cent_value).to eq(0.017)
    expect(card_eight.rewards.second.amount).to eq(50000)

    expect(card_eight.rewards.third.cent_value).to eq(0.017)
    expect(card_eight.rewards.third.amount).to eq(45000)

    expect(card_eight.rewards.fourth.cent_value).to eq(nil)
    expect(card_eight.rewards.fourth.amount).to eq(40000)
  end
end