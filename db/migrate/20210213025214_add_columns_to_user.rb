class AddColumnsToUser < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string
    add_column :users, :avg_cig, :integer
    add_column :users, :cost_a_pack, :float
    add_column :users, :days_smoke_free, :integer
  end
end
