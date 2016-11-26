require "rails_helper"

feature "navbar" do
  include_context "features"

  scenario "user can search for a specific card in the search bar", js: true do
    set_card_categories
    admin_edit
    fill_in_reward_information

    visit root_path

    within(".search-form-test") do
      fill_in "search", with: "South"
      find('#search-button').click
    end

    expect(page).to have_content("2 Cards found")

    within(".flight-list") do
      expect(page).to have_content("Southwest Airlines Rapid Rewards® Premier Credit Card")
      expect(page).to have_content("Southwest Rapid Rewards® Plus Credit Card")
    end

  end

  scenario "user can search for for a card using autocomplete", js: true do
    set_card_categories
    admin_edit
    fill_in_reward_information

    visit root_path

    within(".search-form-test") do
      fill_in "search", with: "South"

    end

    within(".ui-autocomplete") do
      expect(page).to have_content("Southwest Airlines Rapid Rewards® Premier Credit Card")
      expect(page).to have_content("Southwest Rapid Rewards® Plus Credit Card")
    end
  end
end