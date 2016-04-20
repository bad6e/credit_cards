class AddImageUrlToCard < ActiveRecord::Migration
  def change
    add_column :cards, :image_url, :string
  end
end
