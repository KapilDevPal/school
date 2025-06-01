class Payslip < ApplicationRecord
  belongs_to :school
  belongs_to :teacher
  belongs_to :salary_structure

  validates :month, presence: true
  validates :year, presence: true
  validates :basic_salary, presence: true, numericality: { greater_than: 0 }
  validates :total_salary, presence: true, numericality: { greater_than: 0 }
  validates :status, presence: true, inclusion: { in: %w[pending paid] }
  validates :teacher_id, uniqueness: { scope: [:month, :year] }

  before_validation :set_salary_details, on: :create

  def month_year
    "#{Date::MONTHNAMES[month]} #{year}"
  end

  private

  def set_salary_details
    return unless salary_structure

    self.basic_salary = salary_structure.basic_salary
    self.house_rent_allowance = salary_structure.house_rent_allowance
    self.dearness_allowance = salary_structure.dearness_allowance
    self.travel_allowance = salary_structure.travel_allowance
    self.medical_allowance = salary_structure.medical_allowance
    self.total_salary = salary_structure.total_salary
  end
end 