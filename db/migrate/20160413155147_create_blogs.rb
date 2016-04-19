class CreateBlogs < ActiveRecord::Migration
  def change
    create_table :blogs do |t|
      t.string :meta_title
      t.string :meta_description
      t.string :slug

      t.timestamps null: false
    end
  end
end
