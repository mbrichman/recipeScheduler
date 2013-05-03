  class Ingredient < ActiveRecord::Base
  attr_accessible :ingredient, :recipe_id
  belongs_to :recipe
end
