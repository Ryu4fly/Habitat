class AddBalanceToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :balance, :integer
  end
end