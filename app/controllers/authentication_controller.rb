# frozen_string_literal: true

class AuthenticationController < ApplicationController
  def authenticate
    p request.headers['Content-Type']
    return(head(:not_found)) unless user
    @token = JsonWebToken.encode(user_id: user.id)
  end

  private

  def permitted_params
    params.permit(:email, :password)
  end

  def user
    @user ||= User.find_by(email: permitted_params[:email]).
      try(:authenticate, permitted_params[:password])
  end
end
