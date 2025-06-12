class CreateNoticeSchoolClasses < ActiveRecord::Migration[8.0]
  def change
    create_table :notice_school_classes do |t|
      t.references :notice, null: false, foreign_key: true
      t.references :school_class, null: false, foreign_key: true

      t.timestamps
    end

    add_index :notice_school_classes, [:notice_id, :school_class_id], unique: true
  end
end 