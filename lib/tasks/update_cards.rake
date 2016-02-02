desc "Update user commits"
task :update_cards => :environment do
  puts "To Infinity and Beyond!"
  require 'nokogiri'
  require 'open-uri'

  @page = Nokogiri::HTML(open("http://thepointsguy.com/credit-cards/airline/"))

  # Card Name
  @list = @page.css(".card-header").css("h2").map do |cc|
    cc.text
  end
  puts "Mapped card names"

  #Intro Rate
  @rate = @page.css(".stat-two").css(".bottom").map do |rate|
    rate.text
  end
  puts "Mapped Intro Rates"

  #APR
  @apr = @page.css(".stat-three").css(".bottom").map do |apr|
    apr.text
  end
  puts "Mapped APR"

  # Fee
  @fee = @page.css(".stat-four").css(".bottom").map do |fee|
    fee.text
  end
  puts "Mapped card fees"

  # Image
  @image = @page.css(".card-left").css('img').map do |image|
    image.attr('src')
  end
  puts "Mapped Image URL"


  #Card Details
  @links = @page.css('.terms').css('a').map { |link| link['href'] }

  individual_details = []
  grouped_details = []
  n = 0
  @links.each do |link|
    @new_page = Nokogiri::HTML(open("http://thepointsguy.com/#{link}"))
    stuff = @new_page.css(".card-right").css("ul").children.each do |r|
      individual_details << r.text
    end
    puts "Did card #{n}"
    n += 1
    grouped_details << individual_details
    individual_details = []
  end

  #Organize Data
  @data_one = @list.zip(@fee)
  @data_two = @data_one.zip(@apr)

  @data_three = @data_two.map do |r|
    r.flatten
  end

  @data_four = @data_three.zip(@rate)

  @data_five = @data_four.map do |r|
    r.flatten
  end

  @data_six = @data_five.zip(@image)

  @data_seven = @data_six.map do |r|
    r.flatten
  end

  @data = @data_seven.zip(grouped_details)

  #Save Data
  @data.each do |data|
    Card.find_or_create_by(name: data[0][0]) do |card|
      card.annual_fee  = data[0][1]
      card.apr         = data[0][2]
      card.intro_rate  = data[0][3]
      card.image_link  = data[0][4]
      card.information = data[1]
    end
  end

  puts "Update Card Database"
  puts "All done Mr. Doucette"
end