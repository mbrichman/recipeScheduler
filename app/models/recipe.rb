class Recipe < ActiveRecord::Base
  attr_accessible :name, :source, :time, :url
  belongs_to :menu
  has_many :ingredients
end
