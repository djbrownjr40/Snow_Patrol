class CreateSkiResorts < ActiveRecord::Migration[7.0]
  def change
    create_table :ski_resorts do |t|
      t.string :name
      t.string :location
      t.text :description
      t.integer :average_rating
      t.string :url
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
