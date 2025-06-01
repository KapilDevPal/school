class Fee < ApplicationRecord
  belongs_to :student
  belongs_to :school

  validates :amount, presence: true, numericality: { greater_than: 0 }
  validates :due_date, presence: true
  validates :status, presence: true, inclusion: { in: %w[pending paid overdue] }
  validates :payment_date, presence: true, if: :paid?
  validates :payment_method, presence: true, if: :paid?

  def paid?
    status == 'paid'
  end

  def pending?
    status == 'pending'
  end

  def overdue?
    status == 'overdue'
  end
end 