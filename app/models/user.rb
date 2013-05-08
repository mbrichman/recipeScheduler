class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  has_many   :recipeboxes
  validates  :email, :uniqueness => true,
                    :length => {:within => 6..40}
end
