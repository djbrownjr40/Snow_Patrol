class CheckIn < ApplicationRecord
  belongs_to :user
  belongs_to :ski_resort
  has_many :reviews, dependent: :destroy_all
  has_many :snow_reports, dependent: :destroy_all
end
