# frozen_string_literal: true

class UserController < ApplicationController
  def edit
    @current_user.update(permitted_params)
  end

  private

  def permitted_params
    params.permit(:name, :password)
  end
end
