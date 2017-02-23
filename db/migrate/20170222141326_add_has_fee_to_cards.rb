class AddHasFeeToCards < ActiveRecord::Migration
  def change
    add_column :cards, :has_fee, :boolean, default: false
  end
end
