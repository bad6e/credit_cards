require "rails_helper"

feature "admin" do
  include_context "features"

  scenario "admin see card edit form" do
    admin_login

    within("#card-#{card_one.id}") do
      first(:link, "Edit").click
    end

    expect(current_path).to eq(edit_admin_card_path(card_one))
    expect(page).to have_content("Card Details")
    expect(page).to have_content("Card Rewards")
  end

  scenario "admin can edit card details and see updated card show page" do
    admin_edit

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

    expect(current_path).to eq(admin_cards_path)

    within("#card-#{card_one.id}") do
      first(:link, "Edit").click
    end

    within(".edit_card") do
      find_field('card[name]').value.should eq "Test Name1"
      find_field('card[annual_fee]').value.should eq "$99"
      find_field('card[apr]').value.should eq "12.99%"
      find_field('card[intro_rate]').value.should eq "N/A"
      find_field('card[image_link]').value.should eq "www.test.com"
      find_field('card[information]').value.should eq "This is the best card ever. I really like it. Fact.."
    end

    visit card_path(card_one)
    expect(page).to have_content("Test Name1")
    expect(page).to have_content("$99")
    expect(page).to have_content("12.99%")
    expect(page).to have_content("N/A")

    within(".card-description") do
      expect(page).to have_css('ul')
      expect(page).to have_content("This is the best card ever.")
      expect(page).to have_content("I really like it.")
      expect(page).to have_content("Fact.")
    end
  end

  scenario "admin can edit card categories and see updated card on category page" do
    admin_edit
    fill_in_card_information

    expect(current_path).to eq(admin_cards_path)

    expect(card_one.categories.first.name).to eq("airline")
    expect(card_one.categories.second.name).to eq("cash-back")
    expect(card_one.categories.third.name).to eq("travel")

    category_first = Category.find_by(name: 'cash-back')
    visit category_path(category_first)
    expect(page).to have_content("Test Name1")

    category_second = Category.find_by(name: 'airline')
    visit category_path(category_second)
    expect(page).to have_content("Test Name1")
  end

  scenario "admin can't add the same category to the same card twice" do
    admin_edit
    fill_in_card_information

    expect(current_path).to eq(admin_cards_path)

    expect(card_one.categories.first.name).to eq("airline")
    expect(card_one.categories.second.name).to eq("cash-back")
    expect(card_one.categories.third.name).to eq("travel")
    expect(card_one.categories.count).to eq(3)

    visit admin_cards_path
    within("#card-#{card_one.id}") do
      first(:link, "Edit").click
    end

    fill_in "card[name]", with: "Test Name1"
    fill_in "card[annual_fee]", with: "$99"
    fill_in "card[apr]", with: "12.99%"
    fill_in "card[intro_rate]", with: "N/A"
    fill_in "card[image_link]", with: "www.test.com"
    fill_in "card[information]", with: "This is the best card ever. I really like it. Fact."
    select "airline", :from => "card[categories][]"
    select "travel", :from => "card[categories][]"
    select "cash-back", :from => "card[categories][]"
    select "hotel", :from => "card[categories][]"
    click_on "Submit Information"

    expect(card_one.categories.count).to eq(4)
    expect(card_one.categories.include?(Category.find_by(name: "airline"))).to eq(true)
    expect(card_one.categories.include?(Category.find_by(name: "cash-back"))).to eq(true)
    expect(card_one.categories.include?(Category.find_by(name: "travel"))).to eq(true)
    expect(card_one.categories.include?(Category.find_by(name: "hotel"))).to eq(true)
  end

  scenario "admin can edit card information and have the information formatted correctly" do
    admin_edit

    fill_in "card[name]", with: "Test Name1"
    fill_in "card[annual_fee]", with: "$99"
    fill_in "card[apr]", with: "12.99%"
    fill_in "card[intro_rate]", with: "N/A"
    fill_in "card[image_link]", with: "www.test.com"
    fill_in "card[information]", with: "This card has 16.24%. The price on this card is 3.00. I..like this card."
    select "airline", :from => "card[categories][]"
    select "travel", :from => "card[categories][]"
    select "cash-back", :from => "card[categories][]"
    click_on "Submit Information"

    expect(current_path).to eq(admin_cards_path)

    visit card_path(card_one)
    expect(page).to have_content("Test Name1")
    expect(page).to have_content("$99")
    expect(page).to have_content("12.99%")
    expect(page).to have_content("N/A")

    within(".card-description") do
      expect(page).to have_css('ul')
      expect(page).to have_content("This card has 16.24%.")
      expect(page).to have_content("The price on this card is 3.00.")
      expect(page).to have_content("I..like this card.")
    end
  end
end
