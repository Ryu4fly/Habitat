class AddPreferredCurrencyToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :preferred_currency, :string
  end
end
