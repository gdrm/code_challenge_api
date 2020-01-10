# frozen_string_literal: true

json.challenges @challenges do |challenge|
  json.title challenge.title
  json.description challenge.description
  json.examples challenge.examples
  json.test_cases challenge.test_cases
  json.challenge_start_at challenge.challenge_start_at
  json.challenge_end_at challenge.challenge_end_at
end
