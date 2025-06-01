class InventoryItem < ApplicationRecord
  belongs_to :school
  has_many :inventory_transactions, dependent: :destroy

  validates :name, presence: true
  validates :category, presence: true
  validates :quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }
  validates :unit, presence: true
  validates :minimum_quantity, presence: true, numericality: { greater_than_or_equal_to: 0 }

  CATEGORIES = %w[books bags id_cards stationery other].freeze
  UNITS = %w[pieces boxes sets kg].freeze

  def stock_status
    if quantity <= minimum_quantity
      'low'
    elsif quantity <= (minimum_quantity * 1.5)
      'medium'
    else
      'good'
    end
  end

  def needs_restock?
    quantity <= minimum_quantity
  end
end 