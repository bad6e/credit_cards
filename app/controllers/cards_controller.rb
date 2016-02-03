class CardsController < ApplicationController
  def show
    @card = CardPresenter.new(params[:id])
  end
end
