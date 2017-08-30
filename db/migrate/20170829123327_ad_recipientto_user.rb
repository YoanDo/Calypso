class AdRecipienttoUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :recipient_id, :string
  end
end
