class MainProgramCardPrograms < ActiveRecord::Migration
  def change
    create_table :main_program_card_programs do |t|
      t.references :main_program, index: true, foreign_key: true
      t.references :card_program, index: true, foreign_key: true
      t.integer :ratio, default: 0

      t.timestamps null: false
    end
  end
end
