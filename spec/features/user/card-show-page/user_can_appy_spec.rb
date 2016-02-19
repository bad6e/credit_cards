require "rails_helper"

feature "user" do
  include_context "features"

  scenario "user can see apply here button for card in 'Bret's Favorite Cards" do
    set_card_categories
    admin_edit
    fill_in_reward_information

    card_one.categories << Category.find(category_five.id)
    visit card_path(card_one)

    within(".apply-here") do
      expect(page).to have_button('Apply Here')
    end
  end

  scenario "user can NOT see apply here button for card NOT in 'Bret's Favorite Cards" do
    set_card_categories
    admin_edit
    fill_in_reward_information

    visit card_path(card_one)
    expect(page).to_not have_button('Apply Here')
  end
end