class SchoolOwnerSchool < ApplicationRecord
  belongs_to :school_owner
  belongs_to :school

  validates :school_owner_id, uniqueness: { scope: :school_id }
end 