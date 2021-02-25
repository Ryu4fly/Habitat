class AddStartTimeToRace < ActiveRecord::Migration[6.1]
  def change
    add_column :races, :start_time, :datetime
  end
end
