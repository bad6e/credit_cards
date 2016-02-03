desc "Update user commits"
task :update_cards => :environment do
  puts "To Infinity and Beyond!"
  require 'nokogiri'
  require 'open-uri'

  class CardScraper

    def initialize
      open_urls
    end

    def open_urls
      url_list.each do |url|
        @page = Nokogiri::HTML(open("http://thepointsguy.com/credit-cards/#{url}/"))
        @url = url
        save_data
        clean_data
      end
    end

    def url_list
      ["airline","business-rewards","hotel","cash-back"]
    end

    def card_name
      puts "Mapped card names"
      return @page.css(".card-header").css("h2").map {|card| card.text}
    end

    def intro_rate
      puts "Mapped Intro Rates"
      return @page.css(".stat-two").css(".bottom").map {|rate| rate.text}
    end

    def apr
      puts "Mapped APR"
      return @page.css(".stat-three").css(".bottom").map {|apr| apr.text}
    end

    def annual_fee
      puts "Mapped card fees"
      return @page.css(".stat-four").css(".bottom").map {|fee| fee.text}
    end

    def image_url
      puts "Mapped Image URL"
      return @page.css(".card-left").css('img').map {|image| image.attr('src')}
    end

    def card_details
      @links = @page.css('.terms').css('a').map {|link| link['href']}
      individual_details = []
      @grouped_details = []
      n = 1
      @links.each do |link|
        @new_page = Nokogiri::HTML(open("http://thepointsguy.com/#{link}"))
        stuff = @new_page.css(".card-right").css("ul").children.each do |r|
          individual_details << r.text
        end
        puts "Scraped card number #{n}"
        n += 1
        @grouped_details << individual_details
        individual_details = []
      end
    end

    def scrape_data
      @card_name    = card_name
      @intro_rate   = intro_rate
      @apr          = apr
      @annual_fee   = annual_fee
      @image_url    = image_url
      card_details
    end

    def clean_data
      @card_name       = []
      @intro_rate      = []
      @apr             = []
      @annual_fee      = []
      @image_url       = []
      @grouped_details = []
    end

    def organize_data
      @data = @card_name.zip(@annual_fee, @apr, @intro_rate, @image_url, @grouped_details)
    end

    def save_data
      scrape_data
      organize_data
      @data.each do |data|
        Card.find_or_create_by(name: data[0]) do |card|
          card.annual_fee  = data[1]
          card.apr         = data[2]
          card.intro_rate  = data[3]
          card.image_link  = data[4]
          card.information = data[5]
        end
        assign_category(data)
      puts "Updated the Card Database"
      end
    end

    def assign_category(data)
      c = Card.find_by(name: data[0])
      if c.categories == []
        c.categories << Category.find_by(name: @url)
      end
    end
  end
  CardScraper.new
end