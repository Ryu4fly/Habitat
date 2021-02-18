class AddContextToEntries < ActiveRecord::Migration[6.1]
  def change
    add_column :entries, :context, :string
  end
end
