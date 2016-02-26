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
  end

  scenario "user can see apply here button for cards with rewards" do
    set_card_categories

    visit card_path(card_one)
    expect(page).to have_title "Southwest Airlines Rapid Rewards® Premier Credit Card | Too Many Miles"

    within(".apply-here") do
      expect(page).to have_button('Apply Here')
    end
  end

  scenario "user can NOT see apply here button for cards with no rewards" do
    set_card_categories
    visit card_path(card_two)
    expect(page).to_not have_button('Apply Here')
  end
end