class AddInfoToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :author, :string
    add_column :blogs, :content, :string
    add_column :blogs, :meta_title, :string
    add_column :blogs, :meta_description, :string
  end
end
