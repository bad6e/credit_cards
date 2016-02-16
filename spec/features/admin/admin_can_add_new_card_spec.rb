require "rails_helper"

feature "admin" do
  include_context "features"

  scenario "admin can add new card" do
    admin_login

    click_on "Add New Card"
    expect(current_path).to eq(new_admin_card_path)
    expect(page).to have_content("Add a New Card")

    fill_in "card[name]", with: "Test Name1"
    fill_in "card[annual_fee]", with: "$99"
    fill_in "card[apr]", with: "12.99%"
    fill_in "card[intro_rate]", with: "N/A"
    fill_in "card[image_link]", with: "www.test.com"
    click_on "Submit Information"

    expect(current_path).to eq(admin_cards_path)
    expect(page).to have_content("Test Name1")
  end
end
