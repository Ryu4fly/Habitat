class CreateBets < ActiveRecord::Migration[6.1]
  def change
    create_table :bets do |t|
      t.integer :bet_amount
      t.references :user, null: false, foreign_key: true
      t.references :lane, null: false, foreign_key: true

      t.timestamps
    end
  end
end
