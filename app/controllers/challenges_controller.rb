# frozen_string_literal: true

class ChallengesController < ApplicationController
  def index
    @challenges = Challenge.all
  end
end
