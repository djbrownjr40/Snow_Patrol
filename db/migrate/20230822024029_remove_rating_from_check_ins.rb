class RemoveRatingFromCheckIns < ActiveRecord::Migration[7.0]
  def change
    remove_column :check_ins, :rating, :integer
  end
end
