class CreateReviews < ActiveRecord::Migration[7.0]
  def change
    create_table :reviews do |t|
      t.string :comment
      t.integer :waiting_rating
      t.timestamps
    end
  end
end
