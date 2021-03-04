class AddWinningsHaveBeenCollectedToBets < ActiveRecord::Migration[6.1]
  def change
    add_column :bets, :winnings_have_been_collected, :boolean
  end
end
