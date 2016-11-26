require "rails_helper"

feature "Liked Cards in Navbar" do
  include_context "features"

  scenario "User can like a card and see the result in the navbar", js: true do
    set_card_categories

    login_with_facebook
    visit category_path(category_one)

    within('#card-' + card_one.id.to_s) do
      click_on("FAVORITE CARD")
    end

    expect(page).to have_content("1 FAVORITE CARDS")

    # within('#card-' + card_two.id.to_s) do
    #   click_on("FAVORITE CARD")
    # end

    # expect(page).to have_content("2 FAVORITE CARDS")
  end

  scenario "User can like a card and unlike it and see the update", js: true do
    set_card_categories

    login_with_facebook
    visit category_path(category_one)

    within('#card-' + card_one.id.to_s) do
      click_on("FAVORITE CARD")
    end

    expect(page).to have_content("1 FAVORITE CARDS")
    current_user = User.last
    visit user_path(current_user)
    find('.favorite-card-tab').click

    within("#unfavorite-" + card_one.id.to_s) do
      click_on "Unfavorite"
    end

    expect(page).to have_content("0 FAVORITE CARDS")
  end
end
