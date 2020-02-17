require 'rails_helper'

RSpec.describe Solution, type: :model do
  let!(:user) { create(:user) }
  let!(:challenge) { create(:challenge) }

  context 'associations' do
    subject { Solution.new(user: user, challenge: challenge) }
    it { should belong_to(:user) }
    it { should belong_to(:challenge) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:challenge_id) }
    it { should have_many(:comments)}
    it { should have_many(:votes)}
  end
end
