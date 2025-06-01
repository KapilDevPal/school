class TeacherAttendance < ApplicationRecord
  belongs_to :teacher
  belongs_to :school

  validates :date, presence: true
  validates :status, presence: true, inclusion: { in: %w[present absent late] }
  validates :teacher_id, uniqueness: { scope: :date }
end 