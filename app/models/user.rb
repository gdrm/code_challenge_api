class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true

  belongs_to :role
end
