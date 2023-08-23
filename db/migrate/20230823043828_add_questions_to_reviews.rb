class AddQuestionsToReviews < ActiveRecord::Migration[7.0]
  def change
    add_column :reviews, :lift_wait_rating, :integer
    add_column :reviews, :price_rating, :integer
    add_column :reviews, :crowd_rating, :integer
    add_column :reviews, :food_rating, :integer
    add_column :reviews, :location_rating, :integer
    add_column :reviews, :overall_rating, :integer
  end
end
