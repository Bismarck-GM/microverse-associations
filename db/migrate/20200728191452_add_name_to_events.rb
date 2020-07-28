class AddNameToEvents < ActiveRecord::Migration[6.0]
  def change
    add_column :events, :name, :string, null: false
  end
end
