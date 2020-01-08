# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  let!(:role) { Role.create }

  context 'associations' do
    subject { User.new(role: role) }
    it { is_expected.to validate_uniqueness_of(:email) }
    it { is_expected.to have_secure_password }
    it { is_expected.to belong_to(:role) }
  end
end
