require "rails_helper"

feature "admin" do
  include_context "features"

  scenario "admin can add new card and assign it to multiple categories" do
    admin_login

    click_on "Add New Card"
    expect(current_path).to eq(new_admin_card_path)
    expect(page).to have_content("Add a New Card")

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

    card = Card.last

    expect(card.categories.first.name).to eq("airline")
    expect(card.categories.second.name).to eq("cash-back")
    expect(card.categories.third.name).to eq("travel")

    category_first = Category.find_by(name: 'cash-back')
    visit category_path(category_first)
    expect(page).to have_content("Test Name1")

    category_second = Category.find_by(name: 'airline')
    visit category_path(category_second)
    expect(page).to have_content("Test Name1")
  end

  scenario "admin can add new card and upon saving - card infromation displays correctly" do
    admin_login
    set_card_categories
    click_on "Add New Card"
    fill_in_card_information
    card = Card.last

    expect(current_path).to eq(admin_cards_path)

    expect(page).to have_content("Test Name1")

    visit card_path(card)
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
end
