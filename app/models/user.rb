# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  validates :email, uniqueness: true

  belongs_to :role
  has_many :solutions
end
