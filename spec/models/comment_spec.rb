require 'rails_helper'

RSpec.describe Comment, type: :model do
  let!(:user) { create(:user) }
  let!(:challenge_id) { create(:challenge).id }
  let!(:solution) { create(:solution, user_id: user.id, challenge_id: challenge_id)}

  context 'associations' do
    subject { Comment.new(user_id: user.id, solution_id: solution.id) }
    it { should belong_to(:user) }
    it { should belong_to(:solution) }
  end
end
