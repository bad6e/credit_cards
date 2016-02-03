class CreateBonus < ActiveRecord::Migration
  def change
    create_table :bonus do |t|
      t.integer :amount
      t.integer :spending_amount
      t.date :record_date
      t.references :card, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
