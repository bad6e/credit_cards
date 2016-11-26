require "rails_helper"
require 'rake'
Rake::Task.clear
CreditCards::Application.load_tasks

feature "user - category show page" do
  include_context "features"

  scenario "user can all the cards for a specific category", js: true do
    set_card_categories

    visit category_path(category_one)

    expect(page).to have_content "Southwest Airlines Rapid Rewards® Premier Credit Card"
    expect(page).to have_content "Southwest Rapid Rewards® Plus Credit Card"
    expect(page).to have_content "Capital One® Venture® Rewards Credit Card"
    expect(page).to have_content "Chase Sapphire Preferred® Card"
    expect(page).to have_content "Barclaycard Arrival Plus™ World Elite MasterCard®"

    visit category_path(category_two)
    within("#card-#{card_one.id}") do
      expect(page).to have_content "Southwest Airlines Rapid Rewards® Premier Credit Card"
      expect(page).to have_content "--"
      expect(page).to have_content "$99"
    end
  end

  scenario "user can see rating of N/A cards on category show page", js: true do
    set_card_categories

    Reward.create(amount: 55000,
              length_of_time: 2,
              record_date: "2016-02-18",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-11",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Rake::Task["set_best_offer"].execute
    visit category_path(category_one)

    within("#card-#{card_one.id}") do
      expect(page).to have_content "Southwest Airlines Rapid Rewards® Premier Credit Card"
      expect(page).to have_content "N/A"
      expect(page).to have_content "55,000"
    end
  end

  scenario "user can see rating of YES cards on category show page", js: true do
    set_card_categories

    Reward.create(amount: 50000,
              length_of_time: 2,
              record_date: "2016-02-10",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-09",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-08",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-07",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-06",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

     Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-05",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-04",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)


    Rake::Task["set_best_offer"].execute
    visit category_path(category_one)

    within("#card-#{card_one.id}") do
      expect(page).to have_content "Southwest Airlines Rapid Rewards® Premier Credit Card"
      expect(page).to have_content "YES"
      expect(page).to have_content "50,000"
    end
  end

  scenario "user can see rating of NO cards on category show page", js: true do
    set_card_categories

    Reward.create(amount: 35000,
              length_of_time: 2,
              record_date: "2016-02-10",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-09",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-08",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-07",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-06",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

     Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-05",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-04",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Rake::Task["set_best_offer"].execute
    visit category_path(category_one)

    within("#card-#{card_one.id}") do
      expect(page).to have_content "Southwest Airlines Rapid Rewards® Premier Credit Card"
      expect(page).to have_content "NO"
      expect(page).to have_content "35,000"
    end
  end

  scenario "user can see rating of OK cards on category show page", js: true do
    set_card_categories

    Reward.create(amount: 47000,
              length_of_time: 2,
              record_date: "2016-02-10",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-09",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-08",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-07",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-06",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

     Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-05",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Reward.create(amount: 48000,
              length_of_time: 2,
              record_date: "2016-02-04",
              spending_amount: 2000,
              apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
              card_id: card_one.id)

    Rake::Task["set_best_offer"].execute
    visit category_path(category_one)

    within("#card-#{card_one.id}") do
      expect(page).to have_content "Southwest Airlines Rapid Rewards® Premier Credit Card"
      expect(page).to have_content "OK"
      expect(page).to have_content "47,000"
      expect(page).to_not have_content "48,000"
    end
  end

  scenario "user can search for a new category " do
    set_card_categories
    visit category_path(category_one)

    within("#modify-search-panel") do
      select "Travel Credit Cards", :from => "category[category_id]"
    end

    click_on("Search")
    expect(current_path).to eq(category_path(category_four))
  end
end