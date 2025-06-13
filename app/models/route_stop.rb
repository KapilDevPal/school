class RouteStop < ApplicationRecord
  belongs_to :transport_route
  belongs_to :student, optional: true

  validates :stop_name, presence: true
  validates :stop_order, presence: true, numericality: { greater_than: 0 }
  validates :arrival_time, presence: true
  validates :departure_time, presence: true

  scope :ordered, -> { order(stop_order: :asc) }

  validate :departure_after_arrival

  private

  def departure_after_arrival
    return unless arrival_time && departure_time
    if departure_time <= arrival_time
      errors.add(:departure_time, "must be after arrival time")
    end
  end
end 