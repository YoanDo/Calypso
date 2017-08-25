class Removefromto < ActiveRecord::Migration[5.0]
  def change
    remove_column :trips, :from
    remove_column :trips, :to
    remove_column :trips, :to_longitude
    remove_column :trips, :to_latitude
    remove_column :trips, :from_latitude
    remove_column :trips, :from_longitude
  end
end
