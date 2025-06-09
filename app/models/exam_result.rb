class ExamResult < ApplicationRecord
  belongs_to :student
  belongs_to :exam
  belongs_to :subject

  validates :marks_obtained, :total_marks, presence: true
end 