class Api::V1::AutoCompleteController < ApplicationController

  respond_to :json

  def search
    if params[:term]
      @card = Card.order(:name).where('name LIKE ?', "%#{params[:term]}%" )
    else
      @card = Card.all
    end
    render json: @card.to_json
  end

end
