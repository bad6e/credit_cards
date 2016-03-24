class Admin::ImportsController < ApplicationController
  def import
    route_params(params)
  end

  private

  def route_params(params)
    if params[:file]
      upload_csv(params)
    elsif params[:url]
      scrape_monthly_valulations(params)
    end
  end

  def upload_csv(params)
    begin
      Parser.new.parse_csv(params[:file], params[:date])
      flash[:success] = "CSV successfully imported!"
      redirect_to admin_cards_path
    rescue
      flash[:errors] = "Improper Format"
      redirect_to admin_cards_path
    end
  end

  def scrape_monthly_valulations(params)
    MonthlyValuations.new(params[:month], params[:url])
    redirect_to admin_cards_path
  end
end