class AddBestOfferToCards < ActiveRecord::Migration
  def change
    add_column :cards, :best_offer, :integer
  end
end
