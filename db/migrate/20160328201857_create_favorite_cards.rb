class CreateFavoriteCards < ActiveRecord::Migration
  def change
    create_table :favorite_cards do |t|
      t.references :user, index: true, foreign_key: true
      t.references :card, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
