# frozen_string_literal: true

class UserController < ApplicationController
  def edit
    update = @current_user.update(permitted_params)
    head(:ok) if update
  rescue ActiveRecord::RecordNotFound
    head(:not_found) unless update
  end

  private

  def permitted_params
    params.permit(:name, :password)
  end
end
