class AddFeaturesEnabledToSchools < ActiveRecord::Migration[8.0]
  def change
    add_column :schools, :features_enabled, :text
  end
end
