class CreateCardPrograms < ActiveRecord::Migration
  def change
    create_table :card_programs do |t|
      t.string :name
      t.timestamps null: false
    end
  end
end