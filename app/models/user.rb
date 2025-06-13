class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :role, optional: true
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

  validates :email, presence: true, uniqueness: true
  validates :first_name, :last_name, presence: true

  def full_name
    "#{first_name} #{last_name}"
  end

  def has_permission?(permission)
    return true if role&.permissions&.include?('manage_all')
    role&.permissions&.include?(permission)
  end

  def admin?
    role&.name == 'admin'
  end

  def teacher?
    role&.name == 'teacher'
  end

  def student?
    role&.name == 'student'
  end

  def accountant?
    role&.name == 'accountant'
  end

  def school_owner?
    role&.name == 'school_owner'
  end

  def bus_driver?
    role&.name == 'bus_driver'
  end

  def security?
    role&.name == 'security'
  end

  def sweeper?
    role&.name == 'sweeper'
  end

  def peon?
    role&.name == 'peon'
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
