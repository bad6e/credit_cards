class AddRelatedImageUrlToBlogs < ActiveRecord::Migration
  def change
    add_column :blogs, :related_image_url, :string
  end
end
