class Menurecipejoin < ActiveRecord::Base
  attr_accessible :menu_id, :recipe_id
  belongs_to :menu
  belongs_to :recipe
end
