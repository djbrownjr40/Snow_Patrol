class SnowReport < ApplicationRecord
  belongs_to :check_in
  enum rating: %w[no_snow slushy icy groomed_snow packed_powder pow]
  CATEGORIES = ["no_snow", "slushy", "icy", "groomed_snow", "packed_powder", "pow"]


end
