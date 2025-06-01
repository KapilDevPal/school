class Teacher < ApplicationRecord
  belongs_to :school
  has_many :school_classes
  has_many :timetables
  has_many :subjects, through: :timetables

  validates :first_name, :last_name, :email, presence: true
  validates :email, uniqueness: { scope: :school_id }
  # validates :phone_number, presence: true, format: { with: /\A\+?[\d\s-]+\z/, message: "must be a valid phone number" }
  has_secure_password
  def full_name
    "#{first_name} #{last_name}"
  end
end 