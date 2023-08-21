class SkiResort < ApplicationRecord
  has_many :check_ins, dependent: :destroy_all
  has_many :reviews, through: :check_ins
  has_many :snow_reports, through: :check_ins
  has_many :users, through: :check_ins
end
