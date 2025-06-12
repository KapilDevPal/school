class AddThemeSettingsToSchools < ActiveRecord::Migration[8.0]
  def change
    add_column :schools, :primary_color, :string, default: '#4F46E5'  # Indigo-600
    add_column :schools, :secondary_color, :string, default: '#818CF8'  # Indigo-400
    add_column :schools, :accent_color, :string, default: '#C7D2FE'  # Indigo-200
    add_column :schools, :background_color, :string, default: '#FFFFFF'  # White
    add_column :schools, :text_color, :string, default: '#1F2937'  # Gray-900
  end
end 