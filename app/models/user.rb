class User < ApplicationRecord
  has_secure_password

  has_many :chat_rooms, dependent: :destroy
  
  validates :email, uniqueness: true, presence: true
end
