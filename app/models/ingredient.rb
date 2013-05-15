class Ingredient < ActiveRecord::Base
  attr_accessible :ingredient, :recipe_id
  belongs_to :recipe
  validates :recipe, presence: true

  def extract_temp
    if self.ingredient.scan(/\d{3}+(?=\sdegree)/)[0].present?
      self.ingredient.scan(/\d{3}+(?=\sdegree)/)[0].to_s + "°"
    end
  end

  def extract_time
    # if self.ingredient.scan(/[0-9]{1,2}\smin/)[0].present?
      self.ingredient.scan(/([0-9]{1,2})(\shour|\sminute)/)
    # end
  end

end
