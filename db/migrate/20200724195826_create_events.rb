class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :location, null: false
      t.datetime :date, null: false
      t.references :user, null: false, foreign_key: true
      t.string :description, null: false

      t.timestamps
    end
  end
end
