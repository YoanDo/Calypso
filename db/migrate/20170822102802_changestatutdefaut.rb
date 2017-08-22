class Changestatutdefaut < ActiveRecord::Migration[5.0]
  def change
    change_column :trips, :status, :string, :default => "going"
  end
end
