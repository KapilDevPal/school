class SchoolClass < ApplicationRecord
  belongs_to :school
  belongs_to :teacher
  has_many :timetables
  has_many :subjects, through: :timetables
  has_many :students

  validates :name, presence: true
  validates :grade, presence: true
  validates :section, presence: true
  validates :room_number, presence: true
  validates :capacity, presence: true, numericality: { greater_than: 0 }
  validates :name, uniqueness: { scope: :school_id }

  def full_name
    "#{name} - #{teacher&.full_name}"
  end
end 