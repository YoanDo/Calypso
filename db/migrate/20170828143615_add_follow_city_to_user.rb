class AddFollowCityToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :follow_city, :string
  end
end
