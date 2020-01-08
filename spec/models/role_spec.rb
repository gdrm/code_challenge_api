require 'rails_helper'

RSpec.describe Role, type: :model do
  it { should validate_uniqueness_of(:name) }
  it { should validate_uniqueness_of(:code_name) }
end
