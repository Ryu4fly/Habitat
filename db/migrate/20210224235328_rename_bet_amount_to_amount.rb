class RenameBetAmountToAmount < ActiveRecord::Migration[6.1]
  def change
    rename_column :bets, :bet_amount, :amount
  end
end
