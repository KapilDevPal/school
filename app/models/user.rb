class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :school, optional: true
  has_many :notifications, as: :recipient
  has_many :school_owner_schools
  has_many :owned_schools, through: :school_owner_schools, source: :school
  has_many :teacher_classes
  has_many :school_classes, through: :teacher_classes
  has_many :student_classes
  has_many :enrolled_classes, through: :student_classes, source: :school_class
  has_many :teaching_materials, dependent: :destroy
  has_many :leave_applications, dependent: :destroy
  has_many :notices, dependent: :destroy
  has_many :attendances
  has_many :fee_payments
  has_many :exam_results, dependent: :destroy
  has_many :exams, through: :exam_results
  has_many :fees, dependent: :destroy
  has_many :attendance_records, dependent: :destroy
  has_many :assignments, through: :school_classes
  has_many :student_assignments
  has_many :submitted_assignments, through: :student_assignments, source: :assignment

  enum :role, { admin: 0, teacher: 1, student: 2, accountant: 3, school_owner: 4 }, default: :admin

  # Common validations
  validates :email, presence: true, uniqueness: { scope: :school_id }
  validates :role, presence: true
  validates :first_name, :last_name, presence: true

  # Teacher-specific validations
  validates :phone_number, presence: true, format: { with: /\A\+?[\d\s-]+\z/ }, if: :teacher?
  validates :qualification, presence: true, if: :teacher?
  validates :experience, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }, if: :teacher?
  validates :specialization, presence: true, if: :teacher?

  # Student-specific validations
  validates :admission_number, presence: true, uniqueness: { scope: :school_id }, if: :student?
  validates :date_of_birth, presence: true, if: :student?
  validates :roll_number, presence: true, uniqueness: { scope: :school_class_id }, if: :student?
  validates :gender, presence: true, inclusion: { in: %w[male female other] }, if: :student?
  validates :address, presence: true, if: :student?
  validates :parent_name, presence: true, if: :student?
  validates :parent_email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }, if: :student?

  def full_name
    "#{first_name} #{last_name}"
  end

  def admin?
    role == 'admin'
  end

  def teacher?
    role == 'teacher'
  end

  def student?
    role == 'student'
  end

  def accountant?
    role == 'accountant'
  end

  def school_owner?
    role == 'school_owner'
  end

  def current_school
    school_owner? ? owned_schools.first : school
  end

  def age
    return nil unless date_of_birth
    ((Time.zone.now - date_of_birth.to_time) / 1.year.seconds).floor
  end

  def current_class
    return nil unless student?
    enrolled_classes.first
  end
end
