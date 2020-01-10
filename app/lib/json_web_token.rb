# frozen_string_literal: true

class JsonWebToken
  SECRET_KEY = Rails.application.secrets.secret_key_base.to_s

  def self.encode(payload, exp = 24.hours.from_now)
    payload[:exp] = exp.to_i
    JWT.encode(payload, SECRET_KEY)
  end

  def self.decode(token)
    response = JWT.decode(token, SECRET_KEY)[0]
    # will have the data [{"user_id"=>1, "exp"=>1568185252}, {"typ"=>"JWT", "alg"=>"HS256"}]
    # need to strip and fetch the user_id
    HashWithIndifferentAccess.new response
  end
end
