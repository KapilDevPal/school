class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :school
  has_many :notifications, as: :recipient

  enum :role, { admin: 0, teacher: 1, accountant: 2 }, default: :admin

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

  def accountant?
    role == 'accountant'
  end
end
