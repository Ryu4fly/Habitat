class CreateLanes < ActiveRecord::Migration[6.1]
  def change
    create_table :lanes do |t|
      t.references :race, null: false, foreign_key: true
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
