class School < ApplicationRecord
  AVAILABLE_FEATURES = [
    'students',
    'teachers',
    'finance',
    'exams',
    'library',
    'transport',
    'attendance',
    'timetable',
    'notices',
    'fees',
    'inventory',
    'calendar'
  ].freeze

  belongs_to :plan, optional: true
  has_many :school_owner_schools
  has_many :school_owners, through: :school_owner_schools
  has_many :users
  has_many :students
  has_many :teachers
  has_many :school_classes
  has_many :subjects
  has_many :timetables
  has_many :attendance_records
  has_many :teacher_attendances
  has_many :notices
  has_many :fees
  has_many :salary_structures
  has_many :payslips
  has_many :inventory_items
  has_many :inventory_transactions, through: :inventory_items
  has_many :transport_routes

  validates :name, presence: true
  validates :domain, presence: true, uniqueness: true
  validates :subscription_ends_at, presence: true

  before_validation :set_default_subscription_end, on: :create

  def active?
    subscription_ends_at > Time.current
  end

  def features_enabled
    self[:features_enabled] ||= []
  end

  def feature_enabled?(feature)
    features_enabled.include?(feature.to_s)
  end

  def enable_feature(feature)
    return if feature_enabled?(feature)
    self.features_enabled = features_enabled + [feature.to_s]
  end

  def disable_feature(feature)
    return unless feature_enabled?(feature)
    self.features_enabled = features_enabled - [feature.to_s]
  end

  private

  def set_default_subscription_end
    self.subscription_ends_at ||= 30.days.from_now
  end
end
