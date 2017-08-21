class Adddefault < ActiveRecord::Migration[5.0]
  def change
    change_column :trips, :status, :string, :default => "Pending"
    change_column :participants, :status, :string, :default => "Pending"
  end
end
