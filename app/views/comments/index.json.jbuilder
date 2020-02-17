# frozen_string_literal: true

json.comments @comments do |comment|
  json.user_name comment.user.name
  json.comment comment.comment
  json.created_at comment.created_at
end
