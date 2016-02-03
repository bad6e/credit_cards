class CreateCategorizings < ActiveRecord::Migration
  def change
    create_table :categorizings do |t|
      t.references :category, index: true, foreign_key: true
      t.references :card, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
