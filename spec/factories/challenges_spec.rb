FactoryBot.define do
  factory :challenge do
    title { "MyString" }
    description { "MyString" }
    examples { "MyString" }
    test_cases { "MyString" }
    challenge_start_at { "2020-01-09 18:09:30" }
    challenge_end_at { "2020-01-09 18:09:30" }
    manually_closed { false }
  end
end
