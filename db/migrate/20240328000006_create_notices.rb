class CreateNotices < ActiveRecord::Migration[8.0]
  def change
    create_table :notices do |t|
      t.string :title, null: false
      t.text :content, null: false
      t.date :start_date, null: false
      t.date :end_date, null: false
      t.string :priority, null: false, default: 'medium'
      t.references :school, null: false, foreign_key: true
      t.references :user, foreign_key: true

      t.timestamps
    end

    add_index :notices, [:school_id, :start_date, :end_date]
  end
end 