class TeacherClass < ApplicationRecord
  belongs_to :teacher
  belongs_to :school_class

  validates :teacher_id, uniqueness: { scope: :school_class_id }
end 