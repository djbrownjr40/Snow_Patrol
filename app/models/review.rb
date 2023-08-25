class Review < ApplicationRecord
  belongs_to :check_in

  # validates :comment, presence: true, length: { minimum: 10, maximum: 500 }
  validates :lift_wait_rating, presence: true, inclusion: { in: 0..5 }
  validates :price_rating, presence: true, inclusion: { in: 0..5 }
  validates :crowd_rating, presence: true, inclusion: { in: 0..5 }
  validates :food_rating, presence: true, inclusion: { in: 0..5 }
  validates :location_rating, presence: true, inclusion: { in: 0..5 }
end
