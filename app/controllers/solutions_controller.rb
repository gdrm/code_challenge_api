# frozen_string_literal: true

class SolutionsController < ApplicationController
  before_action :set_model, only: :index
  def create
    Solution.create(
      user_id: current_user.id,
      challenge_id: permitted_params[:challenge_id],
      code: permitted_params[:code],
      language: permitted_params[:language]
    )
  end

  def index
    @solutions = @model.solutions
  end

  def show
    @solution = current_user.solutions.find_by!(challenge_id: allowed_params[:challenge_id])
    # return unless @solution
  end

  private

  def permitted_params
    params.require(%i[code language])
    params.permit(:challenge_id, :code, :language)
  end

  def set_model
    @model = (Challenge.find(params[:challenge_id]) if params[:challenge_id])
  end

  def allowed_params
    params.permit(:challenge_id)
  end
end
