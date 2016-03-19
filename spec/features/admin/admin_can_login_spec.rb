require "rails_helper"

feature "admin" do
  include_context "features"

  scenario "admin can log in" do
    visit admin_login_path

    fill_in "user[email]", with: admin_one.email
    fill_in "user[password]", with: admin_one.password

    within("#login-page") do
      click_on "Login"
    end

    expect(current_path).to eq(admin_cards_path)
  end

  scenario "admin cannot login with bad credentials" do
    visit admin_login_path

    fill_in "user[email]", with: admin_one.email
    fill_in "user[password]", with: "wrong password"
    within("#login-page") do
      click_on "Login"
    end

    expect(current_path).to eq(admin_login_path)
  end

  scenario "admin can not see admin pages without logging in" do
    visit admin_cards_path

    within('.dialog') do
      expect(page).to have_content("We're sorry, but you are not authorized to view this page! (403)")
    end
  end
end
