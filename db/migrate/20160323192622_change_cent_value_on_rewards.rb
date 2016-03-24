class ChangeCentValueOnRewards < ActiveRecord::Migration
  def change
    change_column :rewards, :cent_value, :float
  end
end
