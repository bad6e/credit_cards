class AddPointTypetoCards < ActiveRecord::Migration
  def change
    add_column :cards, :point_type, :string
  end
end
