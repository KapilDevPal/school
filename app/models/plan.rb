class Plan < ApplicationRecord
  has_many :schools

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :features_enabled, presence: true

  before_validation :set_default_features, on: :create

  AVAILABLE_FEATURES = %w[
    students
    classes
    teachers
    finance
    exams
    library
    attendance
    timetable
    notices
    fees
    transport
  ].freeze

  def features
    AVAILABLE_FEATURES
  end

  private

  def set_default_features
    self.features_enabled ||= []
  end
end
