class CreateHabits < ActiveRecord::Migration[6.1]
  def change
    create_table :habits do |t|
      t.float :cost_a_pack
      t.integer :avg_cig
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
