class CreateSchools < ActiveRecord::Migration[8.0]
  def change
    create_table :schools do |t|
      t.string :name
      t.string :domain
      t.references :plan, null: false, foreign_key: true
      t.datetime :subscription_ends_at

      t.timestamps
    end
  end
end
