# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    password_digest { 'MyString' }
    role { build(:role) }
  end
end
