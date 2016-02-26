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

  scenario "user can see bonus info for cards with bonuses" do
    set_card_categories
    visit card_path(card_one)

    within(".bonus-information") do
      expect(page).to have_content "50000"
      expect(page).to have_content "2"
      expect(page).to have_content "$2,000"
    end
  end

  scenario "user can NOT see bonus for cards with no bonuses" do
    set_card_categories
    visit card_path(card_two)

    within(".bonus-information") do
      expect(page).to_not have_content "50000"
      expect(page).to_not have_content "2"
      expect(page).to_not have_content "$2,000"
    end
  end
end