class SchoolOwner < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :school_owner_schools
  has_many :schools, through: :school_owner_schools
  has_many :notifications, as: :recipient

  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def current_school
    schools.first
  end
end
