require "rails_helper"

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

    expect(page).to have_content "Southwest Airlines Rapid Rewards® Premier Credit Card"
  end
end