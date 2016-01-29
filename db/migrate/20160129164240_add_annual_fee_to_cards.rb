class AddAnnualFeeToCards < ActiveRecord::Migration
  def change
    add_column :cards, :annual_fee, :string
  end
end
