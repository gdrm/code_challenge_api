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
    @solution = current_solution
  end
  
  def update
    current_solution.update!(allowed_update_params)
  end

  private

  def permitted_params
    params.require(%i[code language])
    params.permit(:challenge_id, :code, :language)
  end

  def allowed_update_params
    params.permit(:code, :likes, :language)
  end

  def current_solution
    current_user.solutions.find_by!(challenge_id: params[:challenge_id])
  end

  def set_model
    @model = (Challenge.find(params[:challenge_id]) if params[:challenge_id])
  end
end
