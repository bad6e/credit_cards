class AddUpdatedEmailToUser < ActiveRecord::Migration
  def change
    add_column :users, :updated_email, :boolean
  end
end
