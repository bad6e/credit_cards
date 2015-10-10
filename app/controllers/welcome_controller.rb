class WelcomeController < ApplicationController

  require 'nokogiri'
  require 'open-uri'

  def index
    @page = Nokogiri::HTML(open("http://thepointsguy.com/credit-cards/airline/"))

    @page = @page.css(".card-header").css("h2").map do |cc|
      cc.text
    end
  end


end
