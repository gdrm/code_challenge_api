# frozen_string_literal: true

json.user do
  json.name @user.name
  json.email @user.email
  json.role_name @user.role.name
end
json.token @token
