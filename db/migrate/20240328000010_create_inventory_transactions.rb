class CreateInventoryTransactions < ActiveRecord::Migration[8.0]
  def change
    create_table :inventory_transactions do |t|
      t.string :transaction_type, null: false
      t.integer :quantity, null: false
      t.date :date, null: false
      t.string :reference_number, null: false
      t.text :remarks
      t.references :inventory_item, null: false, foreign_key: true
      t.references :school, null: false, foreign_key: true

      t.timestamps
    end

    add_index :inventory_transactions, [:school_id, :reference_number], unique: true
  end
end 