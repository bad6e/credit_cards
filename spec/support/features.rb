shared_context "features" do
  let!(:category_one) {
    Category.create(name: "airline")
  }

  let!(:category_two) {
    Category.create(name: "hotel")
  }

  let!(:category_three) {
    Category.create(name: "cash-back")
  }

  let!(:category_four) {
    Category.create(name: "travel")
  }

  let!(:admin_one) {
    User.create(first_name: "Bret",
                last_name: "Doucette",
                email: "test@test.com",
                password: "password",
                role: 1)
  }

  let!(:card_one) {
    Card.create(name: "Southwest Airlines Premier",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "www.test-premier.com")
  }

  let!(:card_two) {
    Card.create(name: "Southwest Airlines Plus",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "www.test-plus.com")
  }


  let!(:card_three) {
    Card.create(name: "Chase Preferred",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "www.test-chase.com")
  }

  let!(:card_four) {
    Card.create(name: "Citi Thank You",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "www.test-thankyou.com")
  }

  let!(:card_five) {
    Card.create(name: "Barclays World Travel",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "www.test-barclaystravel.com")
  }

  def set_card_categories
    c1 = Card.find(card_one.id)
    c1.categories << Category.find(category_one.id)

    c2 = Card.find(card_two.id)
    c2.categories << Category.find(category_one.id)

    c3 = Card.find(card_three.id)
    c3.categories << Category.find(category_one.id)

    c4 = Card.find(card_four.id)
    c4.categories << Category.find(category_one.id)

    c5 = Card.find(card_five.id)
    c5.categories << Category.find(category_one.id)
  end

  def admin_login
    visit admin_login_path
    fill_in "user[email]", with: admin_one.email
    fill_in "user[password]", with: admin_one.password
    click_on "Login"
  end

  def admin_edit
    admin_login
    within("#card-#{card_one.id}") do
      first(:link, "Edit").click
    end
  end

  def fill_in_card_information
    fill_in "card[name]", with: "Test Name1"
    fill_in "card[annual_fee]", with: "$99"
    fill_in "card[apr]", with: "12.99%"
    fill_in "card[intro_rate]", with: "N/A"
    fill_in "card[image_link]", with: "www.test.com"
    fill_in "card[information]", with: "This is the best card ever. I really like it. Fact."
    select "airline", :from => "card[categories][]"
    select "travel", :from => "card[categories][]"
    select "cash-back", :from => "card[categories][]"
    click_on "Submit Information"
  end
end
