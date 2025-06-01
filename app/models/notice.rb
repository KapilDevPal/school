class Notice < ApplicationRecord
  belongs_to :school
  belongs_to :user, optional: true

  validates :title, presence: true
  validates :content, presence: true
  validates :start_date, presence: true
  validates :end_date, presence: true
  validates :priority, presence: true, inclusion: { in: %w[low medium high] }

  scope :active, -> { where('start_date <= ? AND end_date >= ?', Date.current, Date.current) }
  scope :by_priority, -> { order(priority: :desc) }
end 