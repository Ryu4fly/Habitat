class RemoveSartTimeFromRace < ActiveRecord::Migration[6.1]
  def change
    remove_column :races, :sart_time, :datetime
  end
end
