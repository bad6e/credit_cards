class AddTimeLengthtoRewards < ActiveRecord::Migration
  def change
    add_column :rewards, :length_of_time, :integer
  end
end
