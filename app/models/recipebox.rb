  class Recipebox < ActiveRecord::Base
  attr_accessible :recipe_id, :user_id
  has_many   :recipeboxjoins
  has_many   :recipes#, :through => :recipeboxjoins
  belongs_to :user

  def directions(recipe_id)
    return Ingredient.where(:recipe_id => recipe_id)
  end
end
