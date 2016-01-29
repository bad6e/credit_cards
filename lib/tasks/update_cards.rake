desc "Update user commits"
task :update_cards => :environment do
  puts "To Infinity and Beyond!"
  require 'nokogiri'
  require 'open-uri'

  Card.delete_all

  @page = Nokogiri::HTML(open("http://thepointsguy.com/credit-cards/"))

  # Card Name
  @list = @page.css(".card-header").css("h2").map do |cc|
    cc.text
  end
  puts "Mapped credit cards"

  # Fee
  @fee = @page.css(".stat-four").css(".bottom").map do |fee|
    fee.text
  end

  @data = @list.zip(@fee)

  @data.each do |data|
    Card.create(name: data[0], annual_fee: data[1])
  end

  puts "Update Card Database"
  puts "All done Mr. Doucette"
end