class Review < ApplicationRecord
  belongs_to :check_in

  validates :comment, presence: true, length: { minimum: 10, maximum: 500 }
  validates :waiting_rating, presence: true, inclusion: { in: 0..5 }
end
