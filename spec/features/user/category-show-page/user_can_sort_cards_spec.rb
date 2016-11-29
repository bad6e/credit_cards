require "rails_helper"
require 'rake'
Rake::Task.clear
CreditCards::Application.load_tasks

feature "user - category show page - sorting" do
  include_context "features"

  scenario "user can sort the cards alphabetically by their names", js: true do
    set_card_categories
    Rake::Task["set_best_offer"].execute

    visit category_path(category_one)
    within(".sort-by-section") do
      select("Card Name", from: "sort-buttons")
    end

    expect(page.first(:css, '#cat-card-title').text).to eq(("Barclaycard Arrival Plus™ World Elite MasterCard®"))
  end

  scenario "user can sort the cards by their bonus amount(POINTS)", js: true do
    Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2016-02-10",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_three.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-09",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_three.id)

     Reward.create(amount: 45000,
              length_of_time: 2,
              record_date: "2016-02-09",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_two.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-08",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_two.id)

     Reward.create(amount: 57000,
              length_of_time: 2,
              record_date: "2016-02-07",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 60000,
              length_of_time: 2,
              record_date: "2016-02-06",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    set_card_categories
    Rake::Task["set_best_offer"].execute
    visit category_path(category_one)

    within(".sort-by-section") do
      select("Bonus in Points", from: "sort-buttons")
    end

    expect(page.first(:css, '#cat-card-title').text).to eq(("Southwest Airlines Rapid Rewards® Premier Credit Card"))
  end


  scenario "user can sort the cards by their bonus amount(DOLLARS)", js: true do
    Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2016-02-10",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              dollar_amount: 1000,
              card_id: card_three.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-09",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              dollar_amount: 980,
              card_id: card_three.id)

     Reward.create(amount: 45000,
              length_of_time: 2,
              record_date: "2016-02-10",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              dollar_amount: 900,
              card_id: card_two.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-09",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              dollar_amount: 1000,
              card_id: card_two.id)

     Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2016-02-10",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              dollar_amount: 700,
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-09",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              dollar_amount: 1000,
              card_id: card_one.id)

    set_card_categories
    Rake::Task["set_best_offer"].execute
    visit category_path(category_one)

    within(".sort-by-section") do
      select("Bonus in Dollars", from: "sort-buttons")
    end

    expect(page.first(:css, '#cat-card-title').text).to eq(("Chase Sapphire Preferred® Card"))
  end

  scenario "user can sort the cards by their bonus amount(DOLLARS) and if same amount defaults to alphabetically", js: true do
    Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2016-02-10",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              dollar_amount: 1000,
              card_id: card_three.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-09",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              dollar_amount: 980,
              card_id: card_three.id)

     Reward.create(amount: 45000,
              length_of_time: 2,
              record_date: "2016-02-10",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              dollar_amount: 1000,
              card_id: card_two.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-09",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              dollar_amount: 1000,
              card_id: card_two.id)

     Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2016-02-10",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              dollar_amount: 700,
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-09",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              dollar_amount: 1000,
              card_id: card_one.id)

    set_card_categories
    Rake::Task["set_best_offer"].execute
    visit category_path(category_one)

     within(".sort-by-section") do
      select("Bonus in Dollars", from: "sort-buttons")
    end

    expect(page.first(:css, '#cat-card-title').text).to eq(("Chase Sapphire Preferred® Card"))
  end
end