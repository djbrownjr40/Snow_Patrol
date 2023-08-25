class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :check_ins, dependent: :destroy
  has_many :reviews, through: :check_ins
  has_many :snow_reports, through: :check_ins
  has_many :ski_resorts, through: :check_ins

  def checked_in_today?(resort)
    check_ins.find_by(user: self, ski_resort: resort, created_at: Date.today.all_day)
  end
  # validates :username, :first_name, :last_name, presence: true
end
