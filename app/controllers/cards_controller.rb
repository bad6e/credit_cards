class CardsController < ApplicationController

  def index
    @cards = Card.all
    if params[:search]
      @cards = Card.search(params[:search]).order("created_at DESC")
    else
      @cards = Card.all.order('created_at DESC')
    end
  end

  def show
    @card = CardPresenter.new(params[:id])
  end
end
