class CreateTeachingMaterials < ActiveRecord::Migration[8.0]
  def change
    create_table :teaching_materials do |t|
      t.references :teacher, null: false, foreign_key: true
      t.references :school_class, null: false, foreign_key: true
      t.string :title, null: false
      t.text :content, null: false
      t.timestamps
    end
  end
end 