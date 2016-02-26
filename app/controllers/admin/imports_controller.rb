class Admin::ImportsController < ApplicationController
  def import
    Parser.parse_csv(params[:file])
    flash[:success] = "CSV successfully imported!"
    redirect_to admin_cards_path
  end
end
