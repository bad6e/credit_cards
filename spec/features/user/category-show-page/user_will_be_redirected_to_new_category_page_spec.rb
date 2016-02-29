require "rails_helper"

feature "user - category show page - redirect" do
  include_context "features"

  scenario "user will be redirected when to correct category page when using /categories in url" do
    set_card_categories

    visit "/categories/airline-credit-cards"
    expect(current_path).to eq(category_path(category_one))
    expect(page).to have_content "Southwest Airlines Rapid Rewards® Premier Credit Card"
    expect(page).to have_content "Southwest Rapid Rewards® Plus Credit Card"
    expect(page).to have_content "Capital One® Venture® Rewards Credit Card"
    expect(page).to have_content "Chase Sapphire Preferred® Card"
    expect(page).to have_content "Barclaycard Arrival Plus™ World Elite MasterCard®"

    visit "/categories/hotel-credit-cards"
    expect(page).to have_content "Southwest Airlines Rapid Rewards® Premier Credit Card"
  end
end