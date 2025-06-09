class TeachingMaterial < ApplicationRecord
  belongs_to :teacher
  belongs_to :school_class

  validates :title, :content, presence: true
end 