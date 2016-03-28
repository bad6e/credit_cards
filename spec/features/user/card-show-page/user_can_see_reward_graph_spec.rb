require "rails_helper"

feature "user - card show page" do
  include_context "features"

  scenario "user can see the bonus/dollar graph AND cent value graph for cards WITH BOTH rewards and cent values", js: true do
    Reward.create(amount: 50000,
                   length_of_time: 2,
                   record_date: "2016-02-18",
                   spending_amount: 2000,
                   apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                   cent_value: 0.017,
                   dollar_amount: 700,
                   card_id: card_one.id)

    Reward.create(amount: 40000,
                   length_of_time: 2,
                   record_date: "2016-02-11",
                   spending_amount: 2000,
                   apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                   cent_value: 0.017,
                   dollar_amount: 700,
                   card_id: card_one.id)

    Reward.create(amount: 50000,
                  length_of_time: 2,
                  record_date: "2016-02-11",
                  spending_amount: 2000,
                  apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                  cent_value: 0.017,
                  dollar_amount: 700,
                  card_id: card_seven.id)

    set_card_categories
    visit card_path(card_one)
    expect(page).to have_content "Bonus Amount & Value"
    expect(page).to have_content "Rewards Value - #{card_one.point_type}"
    expect(page).to_not have_content("No Bonus Information")
    expect(page).to_not have_content("But Here are Some Cards That Do!")
  end

  scenario "user can see ONLY the bonus AND NOT the cent value graph for cards WITH ONLY rewards and NO cent values", js: true do
    Reward.create(amount: 50000,
                   length_of_time: 2,
                   record_date: "2016-02-18",
                   spending_amount: 2000,
                   apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                   card_id: card_one.id)

    Reward.create(amount: 40000,
                   length_of_time: 2,
                   record_date: "2016-02-11",
                   spending_amount: 2000,
                   apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                   card_id: card_one.id)

    Reward.create(amount: 50000,
                  length_of_time: 2,
                  record_date: "2016-02-11",
                  spending_amount: 2000,
                  apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                  card_id: card_seven.id)

    set_card_categories
    visit card_path(card_one)
    expect(page).to have_content "Bonus Amount"
    expect(page).to_not have_content "Rewards Value - #{card_one.point_type}"
    expect(page).to_not have_content("No Bonus Information")
    expect(page).to_not have_content("But Here are Some Cards That Do!")
  end

  scenario "user can NOT see the bonus reward/dollar graph OR the cent value graph with no rewards but can see respective category and cards with bonuses in those", js: true do
      Reward.create(amount: 50000,
                   length_of_time: 2,
                   record_date: "2016-02-18",
                   spending_amount: 2000,
                   apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                   cent_value: 0.017,
                   dollar_amount: 700,
                   card_id: card_one.id)

     Reward.create(amount: 40000,
                   length_of_time: 2,
                   record_date: "2016-02-11",
                   spending_amount: 2000,
                   apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                   cent_value: 0.017,
                   dollar_amount: 700,
                   card_id: card_one.id)

    Reward.create(amount: 50000,
                  length_of_time: 2,
                  record_date: "2016-02-11",
                  spending_amount: 2000,
                  apply_link: "https://creditcards.chase.com/a1/southwest/2rtfosam1?",
                  cent_value: 0.017,
                  dollar_amount: 700,
                  card_id: card_seven.id)

    set_card_categories
    visit card_path(card_six)
    expect(page).to_not have_content("Bonus Amount & Value")
    expect(page).to_not have_content "Rewards Value - #{card_six.point_type}pe}"
    expect(page).to have_content("No Bonus Information")
    expect(page).to have_content("But Here are some Cash Back Credit Cards with Bonuses!")
    expect(page).to have_content("Chase Cash Back")
    expect(page).to have_content("50000 Points")
  end
end