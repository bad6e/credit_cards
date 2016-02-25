require "rails_helper"

feature "user" do
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

  scenario "user can see reward graph for card in Bret's Favorite Cards" do
    set_card_categories
    admin_edit

    card_one.categories << Category.find(category_five.id)
    visit card_path(card_one)
    expect(page).to have_content "Sign Up Bonus Overtime"
  end

  scenario "user can NOT see reward graph for card NOT in 'Bret's Favorite Cards" do
    set_card_categories
    admin_edit

    visit card_path(card_one)
    expect(page).to_not have_button('Sign Up Bonus Overtime')
  end
end