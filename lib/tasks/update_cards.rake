desc "Update user commits"
task :update_cards => :environment do
  puts "To Infinity and Beyond!"
  require 'nokogiri'
  require 'open-uri'

  Card.delete_all
  puts "Deleted old cards"

  @page = Nokogiri::HTML(open("http://thepointsguy.com/credit-cards/"))

  # Total Commits
  @list = @page.css(".card-header").css("h2").map do |cc|
    cc.text
  end
  puts "Mapped credit cards"

  @list.each do |card|
    Card.create(name: card)
  end
  puts "Update Card Database"
  puts "All done Mr. Doucette"
end