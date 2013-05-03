class Recipe < ActiveRecord::Base
  attr_accessible :name, :source, :time, :url
  has_many :ingredients
end
