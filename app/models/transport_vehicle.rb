class TransportVehicle < ApplicationRecord
  belongs_to :school
  has_many :transport_routes

  validates :name, presence: true
  validates :registration_number, presence: true, uniqueness: { scope: :school_id }
  validates :vehicle_type, presence: true
  validates :capacity, presence: true, numericality: { greater_than: 0 }

  scope :active, -> { where(status: 'active') }

  enum :vehicle_type, {
    bus: 0,
    van: 1,
    car: 2,
    mini_bus: 3
  }
end
