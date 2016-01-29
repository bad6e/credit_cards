class UpdateNameColumnInCards < ActiveRecord::Migration
  def change
    enable_extension 'citext'

    change_column :cards, :name, :citext
  end
end
