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
    fill_in "card[information]", with: "This is the best card ever. I really like it. Fact."
    click_on "Submit Information"

    card = Card.last
    card.categories << Category.first

    expect(current_path).to eq(admin_cards_path)
    expect(page).to have_content("Test Name1")

    visit card_path(card)
    expect(page).to have_content("Test Name1")
    expect(page).to have_content("$99")
    expect(page).to have_content("12.99%")
    expect(page).to have_content("N/A")

    within(".card-description") do
      expect(page).to have_css('ul')
      expect(page).to have_content("This is the best card ever.")
      expect(page).to have_content(" I really like it.")
      expect(page).to have_content("Fact.")
    end


  end
end
