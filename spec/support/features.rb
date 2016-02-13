shared_context "features" do

  def admin_login
    visit admin_login_path

    user = User.create(first_name: "Bret",
                       last_name: "Doucette",
                       email: "test@test.com",
                       password: "password",
                       role: 1)

    fill_in "user[email]", with: user.email
    fill_in "user[password]", with: user.password
    click_on "Login"
  end
end
