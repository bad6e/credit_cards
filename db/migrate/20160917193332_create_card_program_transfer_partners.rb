class CreateCardProgramTransferPartners < ActiveRecord::Migration
  def change
    create_table :card_program_transfer_partners do |t|
      t.references :card, index: true, foreign_key: true
      t.references :card_program, index: true, foreign_key: true
      t.references :transfer_partner, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end