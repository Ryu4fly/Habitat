class AddCigarettesToEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :entries, :cig_smoked, :integer
  end
end
