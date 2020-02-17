# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :set_solution

  def create
    Comment.create(
      user: current_user,
      solution: @solution,
      comment: permitted_params[:comment]
    )
  end

  def index
    @comments = @solution.comments.includes(:user)
    head(:not_found) if @comments.blank?
  end

  private

  def permitted_params
    params.permit(:comment)
  end

  def set_solution
    @solution = Solution.find(params[:solution_id])
  end
end
