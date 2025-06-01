class CreateInventoryItems < ActiveRecord::Migration[8.0]
  def change
    create_table :inventory_items do |t|
      t.string :name, null: false
      t.string :category, null: false
      t.integer :quantity, null: false, default: 0
      t.string :unit, null: false
      t.integer :minimum_quantity, null: false, default: 0
      t.text :description
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end

    add_index :inventory_items, [:school_id, :name], unique: true
  end
end 