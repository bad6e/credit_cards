require "rails_helper"

feature "User Profile Page" do
  include_context "features"

  scenario "user can delete their account", js: true do
    User.delete_all
    expect(User.all.count).to eq(0)
    login_with_facebook
    click_on "ACCOUNT"
    expect(User.all.count).to eq(1)
    within(".delete-account") do
      click_on "DELETE ACCOUNT"
      page.driver.browser.switch_to.alert.accept
    end
    expect(page).to have_content("We are sorry to see you go, Example User!")
    expect(current_path).to eq(root_path)
    expect(User.all.count).to eq(0)
  end

  xscenario "user can update their email account", js: true do
    admin_login
    click_on "ACCOUNT"
    within(".update-email") do
      fill_in "user[email]", with: "bret@isthebest.com"
      sleep(3)
      click_on "UPDATE EMAIL"
    end
    user = User.find_by(first_name: "Bret")
    expect(user.email).to eq("bret@isthebest.com")
    expect(user.updated_email).to eq(true)
  end
end