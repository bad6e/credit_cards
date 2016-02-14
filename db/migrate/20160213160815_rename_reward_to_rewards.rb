class RenameRewardToRewards < ActiveRecord::Migration
  def change
    rename_table :reward, :rewards
  end
end
