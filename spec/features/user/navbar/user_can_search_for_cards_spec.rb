require "rails_helper"

feature "navbar" do
  include_context "features"

  scenario "user can search for a specific card in the search bar" do
    set_card_categories
    admin_edit
    fill_in_reward_information

    visit root_path

    within("#search-form") do
      fill_in "search", with: "South"
      click_on "Go!"
    end

    expect(page).to have_content("Your Search Results Returned 1 Card")


  end

  scenario "user can search for for a card using autocomplete", js: true do
    set_card_categories
    admin_edit
    fill_in_reward_information

    visit root_path

    within("#search-form") do
      fill_in "search", with: "South"

    end

    within(".ui-autocomplete") do
      expect(page).to have_content("Southwest Airlines Premier")
      expect(page).to have_content("Southwest Airlines Plus")
    end
  end

  # scenario "user can NOT see apply here button for card NOT in 'Bret's Favorite Cards" do
  #   set_card_categories
  #   admin_edit
  #   fill_in_reward_information

  #   visit card_path(card_one)
  #   expect(page).to_not have_button('Apply Here')
  # end
end