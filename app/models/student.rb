class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :school
  belongs_to :school_class, optional: true
  has_many :notifications, as: :recipient
  has_many :attendances
  has_many :fee_payments
  has_many :exam_results
  has_many :fees, dependent: :destroy
  has_many :attendance_records, dependent: :destroy

  validates :email, presence: true, uniqueness: { scope: :school_id }
  validates :school, presence: true
  validates :admission_number, presence: true, uniqueness: { scope: :school_id }
  validates :class_section, presence: true
  validates :date_of_birth, presence: true
  validates :first_name, :last_name, presence: true
  # validates :phone_number, presence: true, format: { with: /\A\+?[\d\s-]+\z/, message: "must be a valid phone number" }

  def full_name
    "#{first_name} #{last_name}"
  end

  def age
    ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
  end

  def current_class
    class_section
  end
end
