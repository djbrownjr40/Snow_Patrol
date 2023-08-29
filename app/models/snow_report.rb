class SnowReport < ApplicationRecord
  belongs_to :check_in
  enum rating: %w[no_snow slushy icy groomed_snow packed_powder pow]

  # def rating_number
  #   ratings = %w[no_snow slushy icy groomed_snow packed_powder pow]
  #   return ratings.index(self.rating)
  # end
end
