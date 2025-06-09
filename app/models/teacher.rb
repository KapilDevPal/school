class Teacher < ApplicationRecord
  belongs_to :user
  belongs_to :school
  has_many :teacher_classes, dependent: :destroy
  has_many :school_classes, through: :teacher_classes
  has_many :timetables, through: :school_classes
  has_many :teaching_materials, dependent: :destroy
  has_many :leave_applications, dependent: :destroy
  has_many :notices, dependent: :destroy

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :phone_number, presence: true, format: { with: /\A\+?[\d\s-]+\z/ }
  validates :qualification, presence: true
  validates :experience, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :specialization, presence: true

  has_secure_password

  def full_name
    "#{first_name} #{last_name}"
  end
end 