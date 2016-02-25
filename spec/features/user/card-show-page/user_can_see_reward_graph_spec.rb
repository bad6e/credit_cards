require "rails_helper"

feature "user" do
  include_context "features"

  scenario "user can see reward graph in Bret's Favorite Cards" do
    set_card_categories
    admin_edit
    fill_in_reward_information

    card_one.categories << Category.find(category_five.id)
    visit card_path(card_one)
    expect(page).to have_content "Sign Up Bonus Overtime"
  end

  scenario "user can NOT see reward graph for card NOT in 'Bret's Favorite Cards" do
    set_card_categories
    admin_edit
    fill_in_reward_information

    visit card_path(card_one)
    expect(page).to_not have_button('Sign Up Bonus Overtime')
  end
end