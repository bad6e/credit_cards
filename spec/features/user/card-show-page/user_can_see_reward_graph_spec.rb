require "rails_helper"

feature "user - card show page" do
  include_context "features"
  before(:each) do
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

  end

  scenario "user can see reward graph for cards with rewards", js: true do
    set_card_categories
    visit card_path(card_one)
    expect(page).to have_content "Sign Up Bonus Over Time"
    expect(page).to_not have_content("No Bonus Information for This Card")
    expect(page).to_not have_content("But Here are Some Cards That Do!")
  end

  scenario "user can NOT see reward graph for cards with no rewards but can see respective category and cards with bonuses in those", js: true do
    set_card_categories
    visit card_path(card_six)
    expect(page).to_not have_content('Sign Up Bonus Over Time')
    expect(page).to have_content("No Bonus Information for This Card")
    expect(page).to have_content("But Here are some Cash Back Credit Cards with Bonuses!")
    expect(page).to have_content("Chase Cash Back")
    expect(page).to have_content("50000 Points")
  end
end