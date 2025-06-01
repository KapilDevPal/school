class ChangeFeaturesEnabledToJson < ActiveRecord::Migration[8.0]
  def change
    remove_column :schools, :features_enabled, :text
    add_column :schools, :features_enabled, :json, default: []
  end
end
