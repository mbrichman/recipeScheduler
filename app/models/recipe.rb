class Recipe < ActiveRecord::Base
  attr_accessible :name, :source, :time, :url
  belongs_to :menu
  has_many   :ingredients, :dependent => :destroy
  has_many   :menurecipejoins

  def get_ingredients
    return Ingredient.where(:recipe_id => id, :step_type => 'I')
  end

  def get_directions
    return Ingredient.where(:recipe_id => id, :step_type => 'D')
  end

end
