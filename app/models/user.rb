class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :check_ins, dependent: :destroy_all
  has_many :reviews, through: :check_ins, dependent: :destroy_all
  has_many :snow_reports, through: :check_ins, dependent: :destroy_all
  has_many :ski_reports, through: :check_ins

  validates :username, :first_name, :last_name, presence: true
end
