class CreateMainPrograms < ActiveRecord::Migration
  def change
    create_table :main_programs do |t|
      t.string :name
      t.string :image_url

      t.timestamps null: false
    end
  end
end
