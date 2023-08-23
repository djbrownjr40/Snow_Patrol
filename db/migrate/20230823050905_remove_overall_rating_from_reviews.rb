class RemoveOverallRatingFromReviews < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :overall_rating
  end
end
