class CreateEvents < ActiveRecord::Migration[6.0]
  def change
    create_table :events do |t|
      t.string :location
      t.datetime :date
      t.references :user, null: false, foreign_key: true
      t.string :description

      t.timestamps
    end
  end
end
