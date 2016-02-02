class AddInformationToCards < ActiveRecord::Migration
  def change
    add_column :cards, :information, :string
  end
end
