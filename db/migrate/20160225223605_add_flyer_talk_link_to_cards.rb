class AddFlyerTalkLinkToCards < ActiveRecord::Migration
  def change
    add_column :cards, :flyer_talk_link, :string
  end
end
