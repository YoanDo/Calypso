class CreateSpots < ActiveRecord::Migration[5.0]
  def change
    create_table :spots do |t|
      t.string :name
      t.float :latitude
      t.float :longitude
      t.string :id_surfline
      t.string :address

      t.timestamps
    end
  end
end
