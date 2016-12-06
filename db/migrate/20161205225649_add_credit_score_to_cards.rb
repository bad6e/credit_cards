class AddCreditScoreToCards < ActiveRecord::Migration
  def change
    add_column :cards, :credit_score, :string
  end
end
