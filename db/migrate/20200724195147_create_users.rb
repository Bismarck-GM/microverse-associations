class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :name, null: false
      t.timestamps
    end
    add_index(:users, :name)
  end
end
