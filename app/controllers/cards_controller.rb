class CardsController < ApplicationController

  def index
    format_search_term(params)
    if params[:search]
      @card_count= Card.search(params[:search]).count
    else
      @card_count = Card.all.order('created_at DESC')
    end
  end

  def show
    @card_presenter          = CardPresenter.new(params[:id])
    @featured_card_presenter = FeaturedCardPresenter.new(params[:id])
  end

  private

    def format_search_term(params)
      if params[:search] != ""
        @search_term = "=" + params[:search]
      else
        @search_term = nil
      end
    end
end
