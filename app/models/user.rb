class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :school
  has_many :notifications, as: :recipient
  has_one :teacher
  has_one :student

  enum :role, { admin: 0, teacher: 1, student: 2, accountant: 3, school_owner: 4 }, default: :admin

  validates :email, presence: true, uniqueness: { scope: :school_id }
  validates :role, presence: true
  validates :school, presence: true

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
end
