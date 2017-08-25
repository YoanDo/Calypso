class AddlatlongFrom < ActiveRecord::Migration[5.0]
  def change
    rename_column :trips, :latitude, :to_latitude
    rename_column :trips, :longitude, :to_longitude
    add_column :trips, :from_latitude, :float
    add_column :trips, :from_longitude, :float
  end
end
