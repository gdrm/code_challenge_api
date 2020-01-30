# frozen_string_literal: true

json.solutions @solutions do |solution|
  json.id solution.id
  json.user_name solution.user.name
  json.code solution.code
  json.likes solution.likes
  json.language solution.language
  json.comments []
end
