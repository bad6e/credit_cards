shared_context "features" do
  let!(:category_one) {
    Category.create(name: "airline-credit-cards",
                    slug: "airline-credit-cards")
  }

  let!(:category_two) {
    Category.create(name: "hotel-credit-cards",
                    slug: "hotel-credit-cards")
  }

  let!(:category_three) {
    Category.create(name: "cash-back-credit-cards",
                    slug: "cash-back-credit-cards")
  }

  let!(:category_four) {
    Category.create(name: "travel-credit-cards",
                    slug: "travel-credit-cards")
  }

  let!(:category_five) {
    Category.create(name: "best-credit-card-offers",
                    slug: "best-credit-card-offers")
  }

  let!(:category_six) {
    Category.create(name: "other-credit-cards",
                    slug: "other-credit-cards")
  }

  let!(:category_seven) {
    Category.create(name: "business-rewards-credit-cards",
                    slug: "business-rewards-credit-cards")
  }

  let!(:category_eight ) {
    Category.create(name: "our-favorite-credit-cards",
                    slug: "our-favorite-credit-cards")
  }


  let!(:admin_one) {
    User.create(first_name: "Bret",
                last_name: "Doucette",
                email: "test@test.com",
                password: "password",
                name: "Bret Doucette",
                role: 1)
  }

  let!(:card_one) {
    Card.create(name: "Southwest Airlines Rapid Rewards® Premier Credit Card",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "https://www.google.com/?gws_rd=ssl",
                point_type: "Southwest Rapid Rewards®")
  }



  let!(:card_two) {
    Card.create(name: "Southwest Rapid Rewards® Plus Credit Card",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "https://www.google.com/?gws_rd=ssl")
  }

  let!(:card_three) {
    Card.create(name: "Chase Sapphire Preferred® Card",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "https://www.google.com/?gws_rd=ssl")
  }

  let!(:card_four) {
    Card.create(name: "Capital One® Venture® Rewards Credit Card",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "https://www.google.com/?gws_rd=ssl")
  }

  let!(:card_five) {
    Card.create(name: "Barclaycard Arrival Plus™ World Elite MasterCard®",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                point_type: "Barclay Miles",
                image_link: "https://www.google.com/?gws_rd=ssl")
  }

  let!(:card_six) {
    Card.create(name: "Starwood Preferred Guest® Credit Card from American Express",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "https://www.google.com/?gws_rd=ssl")
  }


  let!(:card_seven) {
    Card.create(name: "Chase Cash Back",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "https://www.google.com/?gws_rd=ssl")
  }

   let!(:card_eight) {
    Card.create(name: "CitiBusiness® / AAdvantage® Platinum Select® World MasterCard®",
                annual_fee: "$99",
                information: ["Bullet A", "Bullet B"],
                apr: "12%",
                intro_rate: "N/A",
                image_link: "https://www.google.com/?gws_rd=ssl",
                point_type: "American AAdvantage® Miles")
  }

  let!(:blog_one) {
     Blog.create(meta_title: "Omg The Southwest Companion Pass: How to Travel for Free ",
                 meta_description: "This is the best deal ever!",
                 image_url: "https://s3.amazonaws.com/card-facebook-images/southwest/bigstock-Southwest-Boeing---36166444.jpg",
                 published: true)
  }

  def set_blog_categories
    card_one.blogs << blog_one
  end

  def set_card_categories
    c1 = Card.find(card_one.id)
    c1.categories << Category.find(category_one.id)
    c1.categories << Category.find(category_two.id)

    c2 = Card.find(card_two.id)
    c2.categories << Category.find(category_one.id)

    c3 = Card.find(card_three.id)
    c3.categories << Category.find(category_one.id)

    c4 = Card.find(card_four.id)
    c4.categories << Category.find(category_one.id)

    c5 = Card.find(card_five.id)
    c5.categories << Category.find(category_one.id)

    c6 = Card.find(card_six.id)
    c6.categories << Category.find(category_three.id)

    c7 = Card.find(card_seven.id)
    c7.categories << Category.find(category_three.id)
  end

  def admin_login
    visit admin_login_path
    fill_in "user[email]", with: admin_one.email
    fill_in "user[password]", with: admin_one.password
    within("#login-page") do
      click_on "Login"
    end
  end

  def admin_edit
    admin_login
    within("#card-#{card_one.id}") do
      first(:link, "Edit").click
    end
  end

  def admin_create_blog
    visit admin_blogs_path

    click_on "Add a New Blog"
    expect(current_path).to eq(new_admin_blog_path)
    expect(page).to have_content("Add New Blog Here")

    fill_in "blog[meta_title]", with: "Test Blog Name"
    fill_in "blog[meta_description]", with: "This is a test description"
    fill_in "blog[image_url]", with: "https://s3.amazonaws.com/card-facebook-images/southwest/bigstock-Southwest-Boeing---36166444.jpg"
    select card_one.name, :from => "blog[cards][]"
    select card_two.name, :from => "blog[cards][]"

    click_on "Submit Blog"
  end

  def fill_in_card_information
    fill_in "card[name]", with: "Test Name1"
    fill_in "card[annual_fee]", with: "$99"
    fill_in "card[apr]", with: "12.99%"
    fill_in "card[intro_rate]", with: "N/A"
    fill_in "card[image_link]", with: "www.test.com"
    fill_in "card[information]", with: "This is the best card ever. I really like it. Fact."
    select category_one.name, :from => "card[categories][]"
    select category_four.name, :from => "card[categories][]"
    select category_three.name, :from => "card[categories][]"
    click_on "Submit Information"
  end

  def fill_in_reward_information
    click_on "Add Another Reward for #{card_one.name}"
    fill_in "reward[amount]", with: 50000
    fill_in "reward[spending_amount]", with: 3000
    fill_in "reward[record_date]", with: "2016-02-18"
    fill_in "reward[length_of_time]", with: 3
    fill_in "reward[apply_link]", with: "www.test.com"
    click_on "Submit Reward Information"
  end

  def login_with_facebook
    visit root_path
    within("#login-navbar") do
      click_on "LOGIN"
    end

    within(".login-social") do
      click_on "Login with Facebook"
    end
  end

  def search_for_term_south
    visit root_path

    within("#search-form") do
      fill_in "search", with: "South"
      find('#search-button').click
    end
  end
end
