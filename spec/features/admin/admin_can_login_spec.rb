require "rails_helper"

feature "admin" do
  scenario "admin can log in" do
    visit admin_login_path

    user = User.create(first_name: "Bret",
                       last_name: "Doucette",
                       email: "test@test.com",
                       password: "password",
                       role: 1)

    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_on "Login"

    expect(current_path).to eq(admin_cards_path)
  end

  scenario "admin cannot login with bad credentials" do
    visit admin_login_path

    user = User.create(first_name: "Bret",
                       last_name: "Doucette",
                       email: "test@test.com",
                       password: "password",
                       role: 1)

    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: "wrong password"
    click_on "Login"

    expect(current_path).to eq(admin_login_path)
  end
end
