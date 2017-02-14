class AddBusCardToCards < ActiveRecord::Migration
  def change
    add_column :cards, :bus_card, :boolean, default: false
  end
end
