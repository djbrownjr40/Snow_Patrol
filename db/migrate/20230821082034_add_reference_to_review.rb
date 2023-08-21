class AddReferenceToReview < ActiveRecord::Migration[7.0]
  def change
    add_reference :reviews, :check_ins, foreign_key: true
  end
end
