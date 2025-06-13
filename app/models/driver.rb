class Driver < ApplicationRecord
  has_many :transport_routes, dependent: :restrict_with_error

  validates :name, presence: true
  validates :license_number, presence: true, uniqueness: true
  validates :phone_number, presence: true
  validates :address, presence: true
  validates :license_expiry_date, presence: true

  scope :active, -> { where(active: true) }

  def license_expired?
    license_expiry_date < Date.current
  end
end 