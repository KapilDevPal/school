class Timetable < ApplicationRecord
  belongs_to :school
  belongs_to :school_class
  belongs_to :subject
  belongs_to :teacher

  validates :day_of_week, presence: true, inclusion: { in: %w[Monday Tuesday Wednesday Thursday Friday] }
  validates :start_time, presence: true
  validates :end_time, presence: true
  validates :room_number, presence: true
  validate :end_time_after_start_time
  # validate :no_overlapping_schedules

  before_validation :set_school_from_class

  private

  def end_time_after_start_time
    return if end_time.blank? || start_time.blank?

    if end_time <= start_time
      errors.add(:end_time, "must be after start time")
    end
  end

  def no_overlapping_schedules
    return if start_time.blank? || end_time.blank? || day_of_week.blank?

    overlapping = Timetable.where(
      school_class: school_class,
      day_of_week: day_of_week
    ).where.not(id: id).where(
      "(start_time <= ? AND end_time > ?) OR (start_time < ? AND end_time >= ?)",
      end_time, start_time, end_time, start_time
    )

    if overlapping.exists?
      errors.add(:base, "Schedule overlaps with another class")
    end
  end

  def set_school_from_class
    self.school = school_class.school if school_class
  end
end 