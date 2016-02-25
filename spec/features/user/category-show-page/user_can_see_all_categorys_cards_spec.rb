require "rails_helper"

feature "user - category show page" do
  include_context "features"

  scenario "user can all the cards for a specific category" do
    set_card_categories

    visit category_path(category_one)

    expect(page).to have_content "Southwest Airlines Premier"
    expect(page).to have_content "Southwest Airlines Plus"
    expect(page).to have_content "Citi Thank You"
    expect(page).to have_content "Chase Preferred"
    expect(page).to have_content "Barclays World Travel"

    visit category_path(category_two)

    expect(page).to have_content "Southwest Airlines Premier"
  end
end