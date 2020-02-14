require 'rails_helper'

RSpec.describe Vote, type: :model do
  context 'associations' do
    it { should belong_to(:user) }
    it { should belong_to(:solution) }
  end
end
