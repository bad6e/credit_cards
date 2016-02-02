class AddAttributesToCards < ActiveRecord::Migration
  def change
    add_column :cards, :apr, :string
    add_column :cards, :intro_rate, :string
    add_column :cards, :image_link, :string
  end
end
