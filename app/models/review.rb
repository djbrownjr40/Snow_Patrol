class Review < ApplicationRecord
  def create
    create_table do |t|
      t.string :comment
      t.integer :waiting_rating
      t.timestamps
    end
  end
end
