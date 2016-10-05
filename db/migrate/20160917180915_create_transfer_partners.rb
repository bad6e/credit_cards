class CreateTransferPartners < ActiveRecord::Migration
  def change
    create_table :transfer_partners do |t|
      t.string :name
      t.string :image_url

      t.timestamps null: false
    end
  end
end
