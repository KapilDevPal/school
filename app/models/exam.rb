class Exam < ApplicationRecord
  belongs_to :school
  belongs_to :school_class
  has_many :exam_results, dependent: :destroy
  has_many :students, through: :exam_results

  validates :name, presence: true
  validates :start_date, :end_date, presence: true
  validate :end_date_after_start_date

  private

  def end_date_after_start_date
    return if end_date.blank? || start_date.blank?

    if end_date < start_date
      errors.add(:end_date, "must be after the start date")
    end
  end
end 