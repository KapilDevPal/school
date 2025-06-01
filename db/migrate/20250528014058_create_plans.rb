class CreatePlans < ActiveRecord::Migration[8.0]
  def change
    create_table :plans do |t|
      t.string :name
      t.decimal :price
      t.json :features_enabled

      t.timestamps
    end
  end
end
