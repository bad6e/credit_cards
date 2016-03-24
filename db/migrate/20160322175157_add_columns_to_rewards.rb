class AddColumnsToRewards < ActiveRecord::Migration
  def change
    add_column :rewards, :dollar_amount, :integer
    add_column :rewards, :cent_value, :integer
    add_column :rewards, :reward_type, :string
  end
end
