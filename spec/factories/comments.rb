FactoryBot.define do
  factory :comment do
    user { nil }
    solution { nil }
    comment { "MyString" }
  end
end
