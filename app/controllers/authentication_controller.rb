# frozen_string_literal: true

class AuthenticationController < ApplicationController
  skip_before_action :authenticate_request

  def authenticate
    @user, @token = AuthenticateUser.call(permitted_params[:email], permitted_params[:password])
    return(head(:not_found)) unless @user
  end

  private

  def permitted_params
    params.permit(:email, :password)
  end
end
