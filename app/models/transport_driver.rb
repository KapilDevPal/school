class TransportDriver < ApplicationRecord
  belongs_to :school
  has_many :transport_routes

  validates :name, presence: true
  validates :license_number, presence: true, uniqueness: { scope: :school_id }
  validates :phone_number, presence: true
  validates :address, presence: true

  scope :active, -> { where(status: 'active') }
end
