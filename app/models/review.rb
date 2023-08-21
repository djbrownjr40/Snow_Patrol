class Review < ApplicationRecord
  belongs_to :check_in

  validates :comment, :waiting_rating, presence: true
end
