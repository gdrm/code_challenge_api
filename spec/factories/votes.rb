FactoryBot.define do
  factory :vote do
    votes { 1 }
    user { nil }
    solution { nil }
  end
end
