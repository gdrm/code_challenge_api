FactoryBot.define do
  factory :solution do
    user { nil }
    challenge { nil }
    code { "MyString" }
    likes { 1 }
    language { "MyString" }
  end
end
