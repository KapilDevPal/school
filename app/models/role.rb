class Role < ApplicationRecord
  belongs_to :school
  has_many :users
end 