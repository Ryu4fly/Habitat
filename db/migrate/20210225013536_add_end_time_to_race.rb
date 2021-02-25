class AddEndTimeToRace < ActiveRecord::Migration[6.1]
  def change
    add_column :races, :end_time, :datetime
  end
end
