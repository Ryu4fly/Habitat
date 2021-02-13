class CreateEntries < ActiveRecord::Migration[6.1]
  def change
    create_table :entries do |t|
      t.date :date
      t.integer :craving
      t.string :feeling
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
