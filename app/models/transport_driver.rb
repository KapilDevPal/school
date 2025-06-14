class TransportDriver < ApplicationRecord
  belongs_to :school
  has_many :transport_routes

  validates :name, presence: true
  validates :license_number, presence: true, uniqueness: { scope: :school_id }
  validates :phone, presence: true
  validates :email, presence: true

  scope :active, -> { where(active: true) }
end
