# frozen_string_literal: true

class AuthenticateUser < ApplicationService
  def initialize(email, password)
    @email = email
    @password = password
  end

  def call
    return nil unless user

    [user, JsonWebToken.encode(user_id: user.id)]
  end

  private

  def user
    @user ||= User.find_by(email: @email).try(:authenticate, @password)
  end
end
