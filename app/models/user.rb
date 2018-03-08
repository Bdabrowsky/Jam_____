class User < ApplicationRecord
before_create :confirmation_token
  has_secure_password
  validates :email, uniqueness: true, presence: true


end
