# frozen_string_literal: true

class ChallengesController < ApplicationController
  def index
    @challenges = Challenge.all
  end

  def show
    @challenge = Challenge.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    head(:not_found) unless @challenge
  end
end
