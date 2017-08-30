class AddDefaultNumber < ActiveRecord::Migration[5.0]
  def change
    change_column :users, :phone, :string, :default => "Not provided"
  end
end
