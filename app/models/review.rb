class Review < ApplicationRecord
  validates :comment, :waiting_rating, presence: true
end
