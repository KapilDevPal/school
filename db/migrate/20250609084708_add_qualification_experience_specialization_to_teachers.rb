class AddQualificationExperienceSpecializationToTeachers < ActiveRecord::Migration[8.0]
  def change
    add_column :teachers, :qualification, :string
    add_column :teachers, :experience, :integer
    add_column :teachers, :specialization, :string
  end
end
