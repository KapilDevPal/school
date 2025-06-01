class Subject < ApplicationRecord
  belongs_to :school
  has_many :timetables
  has_many :school_classes, through: :timetables
  has_many :teachers, through: :timetables

  validates :name, presence: true
  validates :code, presence: true, uniqueness: { scope: :school_id }
  validates :credits, presence: true, numericality: { greater_than: 0 }
  validates :description, presence: true

  def full_name
    "#{name} (#{code})"
  end
end 