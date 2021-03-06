# frozen_string_literal: true

class Solution < ApplicationRecord
  belongs_to :user
  belongs_to :challenge
  validates_uniqueness_of :user_id, scope: [:challenge_id]
  has_many :comments
  has_many :votes
end
