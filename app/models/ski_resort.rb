class SkiResort < ApplicationRecord
  serialize :courses, Hash
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

  def average_of(rating_type)
    return 0 if reviews.nil? || reviews.empty?

    sum = 0
    case rating_type
    when "lift_wait_rating"
      reviews.each do |review|
        sum += review.lift_wait_rating
      end
      sum / reviews.length
    when "price_rating"
      reviews.each do |review|
        sum += review.price_rating
      end
      sum / reviews.length
    when "crowd_rating"
      reviews.each do |review|
        sum += review.crowd_rating
      end
      sum / reviews.length
    when "food_rating"
      reviews.each do |review|
        sum += review.food_rating
      end
      sum / reviews.length
    when "location_rating"
      reviews.each do |review|
        sum += review.location_rating
      end
      sum / reviews.length
    end
  end

  def current_condition
    reports = snow_reports.where("DATE(snow_reports.created_at) = ?", Date.today)
    return "no_report" unless reports.present?

    reports.group(:rating).count.max_by { |condition, count| count }[0]
  end

  def current_condition_number
    conditions = %w[no_report no_snow slushy icy groomed_snow packed_powder pow]
    conditions.index(current_condition)
  end
end
