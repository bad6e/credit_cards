class Admin::ImportsController < ApplicationController
  def import
    begin
      Parser.new.parse_csv(params[:file], params[:date])
      flash[:success] = "CSV successfully imported!"
      redirect_to admin_cards_path
    rescue
      flash[:errors] = "Improper Format"
      redirect_to admin_cards_path
    end
  end
end