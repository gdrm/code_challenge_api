require 'rails_helper'

RSpec.describe Comment, type: :model do

  context 'associations' do
    (Comment.new)
    it { should belong_to(:user) }
    it { should belong_to(:solution) }
  end
end
