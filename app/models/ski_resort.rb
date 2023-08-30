class SkiResort < ApplicationRecord
  serialize :features, Hash
  geocoded_by :location
  after_validation :geocode, if: :will_save_change_to_location?

  has_many :check_ins, dependent: :destroy
  has_many :reviews, through: :check_ins
  has_many :snow_reports, through: :check_ins
  has_many :users, through: :check_ins
  has_one_attached :photo

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

  def average_rating
    return 0 if reviews.nil? || reviews.empty?

    sum = 0
    reviews.each do |review|
      review_avg = (review.lift_wait_rating +
                    review.price_rating +
                    review.crowd_rating +
                    review.food_rating +
                    review.location_rating) / 5
      sum += review_avg
    end
    sum / reviews.length
  end

  def current_condition
    reports = snow_reports.where("DATE(snow_reports.created_at) = ?", Date.today)
    return unless reports.present?

    reports.group(:rating).count.max_by { |condition, count| count }[0]
  end
end
