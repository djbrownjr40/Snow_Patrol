class SnowReport < ApplicationRecord
  belongs_to :check_in
  enum rating: %w[clear rain ice snowy pow]
end
