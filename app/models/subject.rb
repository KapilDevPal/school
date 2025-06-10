class Subject < ApplicationRecord
  belongs_to :school
  has_many :timetables
  has_many :school_classes, through: :timetables
  has_many :teachers, through: :timetables
  has_many :assignments

  validates :name, presence: true
  validates :code, presence: true, uniqueness: { scope: :school_id }
  validates :credits, numericality: { only_integer: true, greater_than: 0 }, allow_nil: true
  validates :description, presence: true, allow_nil: true

  def full_name
    "#{name} (#{code})"
  end
end 