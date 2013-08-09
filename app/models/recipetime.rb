class Recipetime < ActiveRecord::Base
  attr_accessible :amount, :ingredient_id, :interval
  belongs_to :ingredient
end
