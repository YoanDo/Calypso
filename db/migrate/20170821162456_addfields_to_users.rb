class AddfieldsToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :description, :string
    add_column :users, :level, :string
    add_column :users, :location, :string
    add_column :users, :language, :string
  end
end
