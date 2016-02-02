desc "Update user commits"
task :update_cards => :environment do
  puts "To Infinity and Beyond!"
  require 'nokogiri'
  require 'open-uri'

  Card.delete_all

  @page = Nokogiri::HTML(open("http://thepointsguy.com/credit-cards/airline/"))

  # Card Name
  @list = @page.css(".card-header").css("h2").map do |cc|
    cc.text
  end
  puts "Mapped card names"

  # Fee
  @fee = @page.css(".stat-four").css(".bottom").map do |fee|
    fee.text
  end
  puts "Mapped card fees"

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
  @data_two = @data_one.zip(grouped_details)

  #Save Data
  @data_two.each do |data|
    Card.create(name: data[0][0], annual_fee: data[0][1], information: data[1])
  end

  puts "Update Card Database"
  puts "All done Mr. Doucette"
end