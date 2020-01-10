# frozen_string_literal: true

class AuthenticateRequest < ApplicationService
  def initialize(headers)
    @auth_token = headers['AUTHORIZATION']
  end

  def call
    return nil unless @auth_token && user
    user
  end

  private

  def user
    @user ||= User.find(JsonWebToken.decode(@auth_token)[:user_id])
  end
end
