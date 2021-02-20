class RemoveCostAPackFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :cost_a_pack, :float
  end
end
