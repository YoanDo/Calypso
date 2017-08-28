class CreateReviews < ActiveRecord::Migration[5.0]
  def change
    create_table :reviews do |t|
      t.integer :rating
      t.string :comment
      t.references :user, foreign_key: true
    end
  end
end
