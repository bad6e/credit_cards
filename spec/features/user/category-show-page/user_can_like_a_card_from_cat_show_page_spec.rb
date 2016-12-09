require "rails_helper"

feature "Liking Cards on Category Show Page" do
  include_context "features"

  scenario "user has to be logged in to like a card - cat show", js: true do
    set_card_categories
    visit category_path(category_one)

    within('#card-' + card_one.id.to_s) do
      page.has_css?("empty-heart")
    end
  end

  scenario "user clicks login button and modal pops up and the user can login - cat show", js: true do
    set_card_categories
    visit category_path(category_one)

    within('#card-' + card_one.id.to_s) do
      find(:css, "svg").click
    end

    expect(page).to have_content("Login with Facebook")
    click_on "Login with Facebook"

    within(".alert") do
      expect(page).to have_content("Welcome, Bret Doucette!")
    end
  end

  scenario "user can like a card and see the liked card on their profile page - cat show", js: true do
    set_card_categories
    login_with_facebook
    visit category_path(category_one)

    within('#card-' + card_one.id.to_s) do
      find(:css, "svg").click
    end

    visit category_path(category_one)

    within('#card-' + card_two.id.to_s) do
      find(:css, "svg").click
    end

    current_user = User.last
    expect(current_user.cards.first.name).to eq("Southwest Airlines Rapid Rewards® Premier Credit Card")
    expect(current_user.cards.count).to eq(2)
    visit user_path(current_user)
    find('.favorite-card-tab').click
    within(".booking-history") do
      expect(page).to have_content("Southwest Airlines Rapid Rewards® Premier Credit Card")
      expect(page).to have_content("Southwest Rapid Rewards® Plus Credit Card")
    end
  end

  scenario "user can unlike a card and see it updated on the respective pages - cat show", js: true do
    set_card_categories
    login_with_facebook
    visit category_path(category_one)

    within('#card-' + card_two.id.to_s) do
      find(:css, "svg").click
    end

    current_user = User.last

    visit user_path(current_user)
    find('.favorite-card-tab').click

    within(".booking-history") do
      expect(page).to have_content(card_two.name)
    end

    visit card_path(card_two)

    within(".FavoriteButton") do
      expect(page).to have_content("FAVORITED!")
    end

    visit category_path(category_one)

    within("#card-" + card_one.id.to_s) do
      page.has_css?("empty-heart")
    end

    within("#card-" + card_two.id.to_s) do
      page.has_css?("heart")
    end
  end
end