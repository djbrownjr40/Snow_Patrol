class RemoveWaitingRatingFromReviews < ActiveRecord::Migration[7.0]
  def change
    remove_column :reviews, :waiting_rating, :integer
  end
end
