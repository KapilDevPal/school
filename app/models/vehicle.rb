class Vehicle < ApplicationRecord
  has_many :transport_routes, dependent: :restrict_with_error

  validates :registration_number, presence: true, uniqueness: true
  validates :vehicle_type, presence: true
  validates :capacity, presence: true, numericality: { greater_than: 0 }
  validates :model, presence: true
  validates :year, presence: true

  enum vehicle_type: {
    bus: 'bus',
    van: 'van',
    minibus: 'minibus'
  }

  scope :active, -> { where(active: true) }
end 