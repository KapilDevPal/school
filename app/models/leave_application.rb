class LeaveApplication < ApplicationRecord
  belongs_to :teacher
  belongs_to :school

  validates :start_date, :end_date, :reason, presence: true
  validates :status, inclusion: { in: %w[pending approved rejected] }, allow_nil: true
end 