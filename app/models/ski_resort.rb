class SkiResort < ApplicationRecord
  has_many :check_ins, dependent: :destroy
  has_many :reviews, through: :check_ins
  has_many :snow_reports, through: :check_ins
  has_many :users, through: :check_ins

  validates :name, presence: true
  validates :location, presence: true
  validates :description, presence: true
  validates :average_rating, presence: true, inclusion: { in: 0..5 }
  validates :url, presence: true
  validates :latitude, presence: true, numericality: { greater_than_or_equal_to: -90.0, less_than_or_equal_to: 90.0 }
  validates :longitude, presence: true, numericality: { greater_than_or_equal_to: -180.0, less_than_or_equal_to: 180.0 }

  include PgSearch::Model
  pg_search_scope :search_by_name_and_location,
  against: [ :name, :location],
  using: {
    tsearch: { prefix: true } # <-- now `superman batm` will return something!
    }
end
