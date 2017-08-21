class Changenamecolum < ActiveRecord::Migration[5.0]
  def change
    rename_column :trips, :starts_to, :starts_at
  end
end
