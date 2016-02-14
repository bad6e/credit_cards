class ChangleBonuName < ActiveRecord::Migration
  def change
    rename_table :bonus, :reward
  end
end
