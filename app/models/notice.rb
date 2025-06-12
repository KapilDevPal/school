class Notice < ApplicationRecord
  belongs_to :school
  belongs_to :user, optional: true
  belongs_to :teacher, optional: true
  has_and_belongs_to_many :school_classes

  validates :title, presence: true
  validates :content, presence: true
  validates :start_date, presence: true, if: :school_notice?
  validates :end_date, presence: true, if: :school_notice?
  validates :priority, presence: true, inclusion: { in: %w[low medium high] }, if: :school_notice?

  scope :active, -> { where('start_date <= ? AND end_date >= ?', Date.current, Date.current) }
  scope :by_priority, -> { order(priority: :desc) }

  before_validation :set_default_dates_and_priority, if: :teacher_notice?

  private

  def school_notice?
    teacher_id.nil?
  end

  def teacher_notice?
    teacher_id.present?
  end

  def set_default_dates_and_priority
    self.start_date ||= Date.current
    self.end_date ||= Date.current + 30.days
    self.priority ||= 'medium'
  end
end 