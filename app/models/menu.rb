class Menu < ActiveRecord::Base
  belongs_to  :user
  has_many    :menurecipejoins, :dependent => :destroy
  has_many    :recipes,
              :through => :menurecipejoins
end
