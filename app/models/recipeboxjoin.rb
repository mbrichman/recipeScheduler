class Recipeboxjoin < ActiveRecord::Base
  attr_accessible :recipe_id, :recipebox_id
  belongs_to :recipebox
  belongs_to :recipe
end
