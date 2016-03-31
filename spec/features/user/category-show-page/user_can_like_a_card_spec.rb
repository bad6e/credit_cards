require "rails_helper"

feature "Liking Cards" do
  include_context "features"

  scenario "user has to be logged in to like a card", js: true do
    set_card_categories
    visit category_path(category_one)

    within('#card-' + card_one.id.to_s) do
      expect(page).to have_content("LOGIN TO FAVORITE")
    end
  end
end