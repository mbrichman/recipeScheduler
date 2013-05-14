class RemoveMenuIdFromRecipes < ActiveRecord::Migration
  def change
    remove_column :recipes, :menu_id
    remove_column :recipes, :key_temps
  end
end
