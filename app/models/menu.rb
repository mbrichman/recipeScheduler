class Menu < ActiveRecord::Base
  belongs_to  :user
  has_many    :menurecipejoins
  has_many    :recipes,
              :through => :menurecipejoins
end
