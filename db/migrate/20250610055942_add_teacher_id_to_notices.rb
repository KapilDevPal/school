class AddTeacherIdToNotices < ActiveRecord::Migration[8.0]
  def change
    add_column :notices, :teacher_id, :integer
  end
end
