class CheckIn < ApplicationRecord
  validates :checked_out_at, presence: true
end
