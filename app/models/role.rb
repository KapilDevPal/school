class Role < ApplicationRecord
  belongs_to :school
  has_many :users

  validates :name, presence: true, uniqueness: { scope: :school_id }

  before_validation :set_default_permissions, on: :create

  scope :active, -> { where(active: true) }

  attribute :permissions, :json

  AVAILABLE_PERMISSIONS = %w[
    manage_all
    manage_students
    manage_teachers
    manage_classes
    manage_exams
    manage_finance
    manage_library
    manage_transport
    manage_attendance
    manage_timetable
    manage_notices
    manage_fees
    manage_staff
    view_reports
  ].freeze

  def self.default_roles
    {
      'admin' => ['manage_all'],
      'teacher' => ['manage_classes', 'manage_attendance', 'manage_notices'],
      'student' => ['view_reports'],
      'accountant' => ['manage_finance', 'manage_fees'],
      'school_owner' => ['manage_all'],
      'bus_driver' => ['manage_transport'],
      'security' => ['manage_attendance'],
      'sweeper' => [],
      'peon' => []
    }
  end

  private

  def set_default_permissions
    return if permissions.present?
    self.permissions = self.class.default_roles[name] || []
  end
end 