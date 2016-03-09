class AboutController < ApplicationController

  def index
    @linked_card = Card.find_by(name: "Chase Sapphire Preferred® Card")
  end
end
