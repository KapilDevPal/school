class AttendanceRecord < ApplicationRecord
  belongs_to :school_class
  belongs_to :student
  belongs_to :school

  validates :date, presence: true
  validates :status, presence: true, inclusion: { in: %w[present absent late] }
  validates :student_id, uniqueness: { scope: [:school_class_id, :date] }

  scope :for_date, ->(date) { where(date: date) }
  scope :for_student, ->(student_id) { where(student_id: student_id) }
  scope :for_class, ->(class_id) { where(school_class_id: class_id) }
end 