# frozen_string_literal: true

class ApplicationController < ActionController::API
  before_action :authenticate_request

  private

  def authenticate_request
    @current_user = AuthenticateRequest.call(request.headers)
    head(:unauthorized) unless @current_user
  end
end
