# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_solution, only: :create

  def create
    Comment.create(
      user: current_user,
      solution: @solution,
      comment: permitted_params[:comment]
    )
  end

  private

  def permitted_params
    params.permit(:comment)
  end

  def set_solution
    @solution = Solution.find(params[:solution_id])
  end
end
