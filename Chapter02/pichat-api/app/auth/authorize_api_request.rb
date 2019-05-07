class AuthorizeApiRequest
  def initialize(headers = {})
    @headers = headers
  end

  def call
    {
      user: user
    }
  end

  private

  def user
    @user ||= User.find(decoded_auth_token[:user_id]) if decoded_auth_token
  rescue ActiveRecord::RecordNotFound => e
    raise(
      ExceptionHandler::InvalidToken, ("#{MessageStrings.invalid_token} #{e.message}"))
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if @headers['Authorization'].present?
      return @headers['Authorization'].split(' ').last
    end
    raise(ExceptionHandler::MissingToken, MessageStrings.missing_token)
  end
end
