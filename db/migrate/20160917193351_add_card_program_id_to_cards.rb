class AddCardProgramIdToCards < ActiveRecord::Migration
  def change
    add_column :cards, :card_program_id, :integer, index: true
    add_column :cards, :main_program_id, :integer, index: true
  end
end
