# frozen_string_literal: true

class Role < ApplicationRecord
  validates :name, uniqueness: true
  validates :code_name, uniqueness: true
end
