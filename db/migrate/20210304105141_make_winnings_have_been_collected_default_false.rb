class MakeWinningsHaveBeenCollectedDefaultFalse < ActiveRecord::Migration[6.1]
  def change
    change_column :bets, :winnings_have_been_collected, :boolean, default: false
  end
end
