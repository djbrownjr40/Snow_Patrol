class CheckIn < ApplicationRecord
  belongs_to :user
  belongs_to :ski_resort
  has_many :reviews, dependent: :destroy
  has_many :snow_reports, dependent: :destroy

end
