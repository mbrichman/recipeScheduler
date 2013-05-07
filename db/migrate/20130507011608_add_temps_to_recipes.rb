class AddTempsToRecipes < ActiveRecord::Migration
  def change
    add_column :recipes, :key_temps, :string
  end
end
