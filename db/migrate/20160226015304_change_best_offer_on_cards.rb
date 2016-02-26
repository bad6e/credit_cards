class ChangeBestOfferOnCards < ActiveRecord::Migration
  def change
    change_column :cards, :best_offer, :string
  end
end
