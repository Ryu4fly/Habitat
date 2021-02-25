class CreateLosses < ActiveRecord::Migration[6.1]
  def change
    create_table :losses do |t|
      t.integer :placing
      t.references :user, null: false, foreign_key: true
      t.references :race, null: false, foreign_key: true

      t.timestamps
    end
  end
end
