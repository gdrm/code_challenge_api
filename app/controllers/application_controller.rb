# frozen_string_literal: true

class ApplicationController < ActionController::API
  attr_reader :current_user
  before_action :authenticate_request
  rescue_from ActionController::ParameterMissing, with: -> { head(:unprocessable_entity) }
  rescue_from ActiveRecord::RecordNotFound, with: -> { head(:not_found) }

  private

  def authenticate_request
    @current_user = AuthenticateRequest.call(request.headers)
    head(:unauthorized) unless @current_user
  end
end
