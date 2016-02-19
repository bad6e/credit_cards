class AddLinkToRewards < ActiveRecord::Migration
  def change
    add_column :rewards, :apply_link, :string, default: 'N/A'
  end
end
