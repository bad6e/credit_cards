require "rails_helper"

feature "Liking Cards from Navbar Search" do
  include_context "features"

  scenario "user has to be logged in to like a card - navbar", js: true do
    set_card_categories

    search_for_term_south

    expect(page).to have_content("2 Cards found")

    within('#card-' + card_one.id.to_s) do
      expect(page).to have_content("LOGIN TO FAVORITE")
    end
  end

  scenario "user clicks login button and modal pops up and the user can login - navbar ", js: true do
    set_card_categories

    search_for_term_south

    within('#card-' + card_one.id.to_s) do
      click_on "LOGIN TO FAVORITE"
    end

    expect(page).to have_content("Login with Facebook")
    click_on "Login with Facebook"

    within(".alert") do
      expect(page).to have_content("Welcome, Bret Doucette!")
    end
  end

  scenario "user can like a card and see the liked card on their profile page - navbar", js: true do
    User.delete_all
    set_card_categories
    login_with_facebook

    search_for_term_south

    within('#card-' + card_one.id.to_s) do
      click_on("FAVORITE CARD")
    end

    within('#card-' + card_two.id.to_s) do
      click_on("FAVORITE CARD")
    end


    current_user = User.last
    expect(current_user.cards.first.name).to eq("Southwest Airlines Rapid Rewards® Premier Credit Card")
    visit user_path(current_user)
    find('.favorite-card-tab').click
    within(".booking-history") do
      expect(page).to have_content("Southwest Airlines Rapid Rewards® Premier Credit Card")
      expect(page).to have_content("Southwest Rapid Rewards® Plus Credit Card")
    end
  end

  scenario "user can unlike a card and see it updated on the respective pages - navbar", js: true do
    User.delete_all
    set_card_categories
    login_with_facebook

    search_for_term_south

    within('#card-' + card_one.id.to_s) do
      click_on("FAVORITE CARD")
    end

    within('#card-' + card_two.id.to_s) do
      click_on("FAVORITE CARD")
    end

    current_user = User.last

    visit user_path(current_user)
    find('.favorite-card-tab').click

    within(".booking-history") do
      expect(page).to have_content("Southwest Airlines Rapid Rewards® Premier Credit Card")
      expect(page).to have_content("Southwest Rapid Rewards® Plus Credit Card")
    end

    within("#unfavorite-" + card_one.id.to_s) do
      click_on "Unfavorite"
    end

    within(".booking-history") do
      expect(page).to_not have_content("Southwest Airlines Rapid Rewards® Premier Credit Card")
      expect(page).to have_content("Southwest Rapid Rewards® Plus Credit Card")
    end

    visit card_path(card_two)

    within(".FavoriteButton") do
      expect(page).to have_content("FAVORITED!")
    end

    visit card_path(card_one)

    within(".FavoriteButton") do
      expect(page).to have_content("FAVORITE CARD")
    end

    visit category_path(category_one)

    within("#card-" + card_one.id.to_s) do
      expect(page).to have_content("FAVORITE CARD")
    end

    within("#card-" + card_two.id.to_s) do
      expect(page).to have_content("FAVORITED!")
    end
  end
end