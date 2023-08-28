class SnowReport < ApplicationRecord
  belongs_to :check_in
  enum rating: %w[No_snow Slushy Icy Groomed_Snow Packed_Powder Pow]
end
