class CreateCardBlogs < ActiveRecord::Migration
  def change
    create_table :card_blogs do |t|
      t.references :card, index: true, foreign_key: true
      t.references :blog, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
