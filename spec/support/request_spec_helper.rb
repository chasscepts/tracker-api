module RequestSpecHelper
  def json
    JSON.parse(response.body)
  end

  def token_generator(user_id)
    JsonWebToken.encode(sub: user_id)
  end

  def expired_token_generator(user_id)
    JsonWebToken.encode({ sub: user_id }, (Time.now.to_i - 10))
  end

  def valid_headers
    {
      'Authorization' => token_generator(user.id),
      'Content-Type' => 'application/json'
    }
  end

  def invalid_headers
    {
      'Authorization' => nil,
      'Content-Type' => 'application/json'
    }
  end
end
