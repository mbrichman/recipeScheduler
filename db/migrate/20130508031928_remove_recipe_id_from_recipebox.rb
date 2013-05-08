class RemoveRecipeIdFromRecipebox < ActiveRecord::Migration
  def change
    remove_column :recipeboxes, :recipe_id
  end
end
