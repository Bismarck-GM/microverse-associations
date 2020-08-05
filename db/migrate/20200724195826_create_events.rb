class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :location, null: false
      t.datetime :date, null: false
      t.references :creator, null: false, index: true, foreign_key: {to_table: :users}
      t.string :description, null: false

      t.timestamps
    end
  end
end
