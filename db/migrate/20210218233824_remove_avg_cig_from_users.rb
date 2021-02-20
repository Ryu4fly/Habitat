class RemoveAvgCigFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :avg_cig, :integer
  end
end
