class TransportRoute < ApplicationRecord
  belongs_to :vehicle
  belongs_to :driver
  has_many :route_stops, dependent: :destroy
  has_many :students, through: :route_stops

  accepts_nested_attributes_for :route_stops, allow_destroy: true, reject_if: :all_blank

  validates :name, presence: true
  validates :cost, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :vehicle_id, presence: true
  validates :driver_id, presence: true

  scope :active, -> { where(active: true) }

  def first_stop
    route_stops.ordered.first
  end

  def last_stop
    route_stops.ordered.last
  end
end 