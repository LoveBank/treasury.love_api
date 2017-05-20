module RequestSpecHelper
  # Parse JSON response to ruby hash
  def json
    JSON.parse(response.body)
  end


  def set_authentication_headers_for(user)
    user_headers = user.create_new_auth_token
    @request.headers.merge!(user_headers)
  end
end