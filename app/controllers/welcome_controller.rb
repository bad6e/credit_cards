class WelcomeController < ApplicationController

  require 'nokogiri'
  require 'open-uri'

  def index
    @cards = Card.all
  end
end
