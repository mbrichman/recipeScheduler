class CreateRecipeboxjoins < ActiveRecord::Migration
  def change
    create_table :recipeboxjoins do |t|
      t.integer :recipebox_id
      t.integer :recipe_id

      t.timestamps
    end
  end
end
