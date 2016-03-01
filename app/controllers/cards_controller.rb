class CardsController < ApplicationController

  def index
    @cards = Card.all
    if params[:search]
      @cards = Card.search(params[:search]).order("created_at DESC").paginate(page: params[:page])
    else
      @cards = Card.all.order('created_at DESC').paginate(page: params[:page])
    end
  end

  def show
    @card_presenter = CardPresenter.new(params[:id])
  end
end
