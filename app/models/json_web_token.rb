class JsonWebToken
  def self.encode(payload)
    JWT.encode payload, Rails.application.credentials.secret_key_base
  end

  def self.decode(token)
    JWT.decode(token, Rails.application.credentials.secret_key_base).first
  end
end
