class Student < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :user
  belongs_to :school
  belongs_to :school_class
  has_many :student_classes, dependent: :destroy
  has_many :classes, through: :student_classes, source: :school_class
  has_many :notifications, as: :recipient
  has_many :attendances
  has_many :fee_payments
  has_many :exam_results, dependent: :destroy
  has_many :exams, through: :exam_results
  has_many :fees, dependent: :destroy
  has_many :attendance_records, dependent: :destroy
  has_many :assignments, through: :school_class
  has_many :student_assignments
  has_many :submitted_assignments, through: :student_assignments, source: :assignment

  validates :email, presence: true, uniqueness: { scope: :school_id }
  validates :school, presence: true
  validates :admission_number, presence: true, uniqueness: { scope: :school_id }
  validates :class_section, presence: true
  validates :date_of_birth, presence: true
  validates :first_name, :last_name, presence: true
  validates :roll_number, presence: true, uniqueness: { scope: :school_class_id }
  validates :gender, presence: true, inclusion: { in: %w[male female other] }
  validates :address, presence: true
  validates :parent_name, presence: true
  validates :parent_phone, presence: true
  validates :parent_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
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
