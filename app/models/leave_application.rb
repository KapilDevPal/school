class LeaveApplication < ApplicationRecord
  belongs_to :teacher
  belongs_to :school
  belongs_to :approved_by, class_name: 'SchoolOwner', optional: true

  validates :start_date, :end_date, :reason, :leave_type, :contact_number, presence: true
  validates :status, inclusion: { in: %w[pending approved rejected] }, allow_nil: true
  validates :leave_type, inclusion: { in: %w[casual sick emergency other] }
  validates :contact_number, format: { with: /\A\+?[\d\s-]+\z/, message: "must be a valid phone number" }
  validate :end_date_after_start_date

  scope :pending, -> { where(status: 'pending') }

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after start date")
    end
  end
end 