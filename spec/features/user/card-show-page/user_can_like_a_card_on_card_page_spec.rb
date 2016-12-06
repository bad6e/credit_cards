require "rails_helper"

feature "Liking Cards on Card Show Page" do
  include_context "features"

  scenario "user has to be logged in to like a card - card show", js: true do
    set_card_categories
    visit card_path(card_one)

    within('.FavoriteButton') do
      expect(page).to have_content("LOGIN TO FAVORITE")
    end
  end

  scenario "user clicks login button and modal pops up and the user can login - card show", js: true do
    set_card_categories
    visit card_path(card_one)

    within('.FavoriteButton') do
      click_on "Login to Favorite"
    end

    expect(page).to have_content("Login with Facebook")
    click_on "Login with Facebook"

    within(".alert") do
      expect(page).to have_content("Welcome, Bret Doucette!")
    end
  end

  scenario "user can like a card and see the liked card on their profile page - card show", js: true do
    set_card_categories
    login_with_facebook
    visit card_path(card_one)

    within('.FavoriteButton') do
      click_on("FAVORITE CARD")
    end

    current_user = User.last
    expect(current_user.cards.first.name).to eq("Southwest Airlines Rapid Rewards® Premier Credit Card")
    expect(current_user.cards.count).to eq(1)

    visit user_path(current_user)
    find('.favorite-card-tab').click
    within(".booking-history") do
      expect(page).to have_content("Southwest Airlines Rapid Rewards® Premier Credit Card")
    end
  end

  scenario "user can unlike a card and see it updated on the respective pages - card show", js: true do
    set_card_categories
    login_with_facebook
    visit card_path(card_one)
    within('.FavoriteButton') do
      click_on("FAVORITE CARD")
    end

    within('.FavoriteButton') do
      click_on("FAVORITED!")
    end

    visit category_path(category_one)

    within("#card-" + card_one.id.to_s) do
      page.has_css?("heart")
    end

    current_user = User.last

    visit user_path(current_user)
    find('.favorite-card-tab').click

    within(".booking-history") do
      expect(page).to have_content("Southwest Airlines Rapid Rewards® Premier Credit Card")
    end

    within("#unfavorite-" + card_one.id.to_s) do
      click_on "Unfavorite"
    end

    within(".booking-history") do
      expect(page).to_not have_content("Southwest Airlines Rapid Rewards® Premier Credit Card")
    end

    visit card_path(card_one)

    within(".FavoriteButton") do
      expect(page).to have_content("FAVORITE CARD")
    end

    visit category_path(category_one)

    within("#card-" + card_one.id.to_s) do
      page.has_css?("heart")
    end
  end
end