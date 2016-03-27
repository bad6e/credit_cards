require "rails_helper"

feature "Facebook Oauth" do
  include_context "features"

  scenario "visitor can LOGIN with Facebook Oauth", js: true do
    set_card_categories
    visit root_path
    within("#login-navbar") do
      click_on "LOGIN"
    end

    within(".login-social") do
      click_on "Login with Facebook"
    end
    within(".alert") do
      expect(page).to have_content("Welcome, Bret Doucette!")
    end
    expect(page).to have_content("ACCOUNT")
    expect(page).to have_content("LOGOUT")
    expect(page).to_not have_content ("SIGN UP")
    expect(page).to_not have_content ("LOGIN")
  end

  scenario "visitor can SIGN UP with Facebook Oauth", js: true do
    set_card_categories
    visit root_path
    within("#login-navbar") do
      click_on "SIGN UP"
    end

    within(".login-social") do
      click_on "Join with Facebook"
    end
    within(".alert") do
      expect(page).to have_content("Welcome, Bret Doucette!")
    end
    expect(page).to have_content("ACCOUNT")
    expect(page).to have_content("LOGOUT")
    expect(page).to_not have_content ("SIGN UP")
    expect(page).to_not have_content ("LOGIN")
  end

  scenario "visitor can LOG OUT after using Facebook Oauth", js: true do
    set_card_categories
    login_with_facebook

    within("#logout-link") do
      click_on "LOGOUT"
    end

    within("#login-navbar") do
      expect(page).to have_content ("SIGN UP")
      expect(page).to have_content ("LOGIN")
      expect(page).to_not have_content ("ACCOUNT")
    end
  end
end