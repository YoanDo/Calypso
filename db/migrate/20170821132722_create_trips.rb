class CreateTrips < ActiveRecord::Migration[5.0]
  def change
    create_table :trips do |t|
      t.string :title
      t.string :from
      t.string :to
      t.datetime :starts_to
      t.datetime :ends_at
      t.integer :estimated_duration
      t.text :description
      t.integer :nb_participant
      t.references :user, foreign_key: true
      t.string :status
      t.string :category
      t.string :car
      t.string :house
      t.string :equipment

      t.timestamps
    end
  end
end
