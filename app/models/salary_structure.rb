class SalaryStructure < ApplicationRecord
  belongs_to :school
  belongs_to :teacher

  validates :basic_salary, presence: true, numericality: { greater_than: 0 }
  validates :house_rent_allowance, :dearness_allowance, :travel_allowance, :medical_allowance, 
            numericality: { greater_than_or_equal_to: 0 }, allow_nil: true

  def total_salary
    basic_salary + 
    (house_rent_allowance || 0) + 
    (dearness_allowance || 0) + 
    (travel_allowance || 0) + 
    (medical_allowance || 0)
  end
end 