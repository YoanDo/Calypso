class CreateLocations < ActiveRecord::Migration[5.0]
  def change
    create_table :locations do |t|
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :direction
      t.references :trip, foreign_key: true
      t.timestamps
    end
  end
end

