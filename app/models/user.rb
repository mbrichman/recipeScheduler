class User < ActiveRecord::Base
  attr_accessible :email, :password, :password_confirmation
  has_secure_password
  validates :email, :uniqueness => true,
                    :length => {:within => 6..40}
end
