class ChangeInformationOnCards < ActiveRecord::Migration
  def change
    change_column :cards, :information, :text, array: true, default: [], using: "(string_to_array(information, ','))"
  end
end
