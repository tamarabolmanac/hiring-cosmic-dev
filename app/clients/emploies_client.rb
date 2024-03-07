class EmploiesClient
  URL_BASE_PATH = "https://beta.01cxhdz3a8jnmapv.com/api/v1/assignment"

  def initialize
    @access_token = get_token
  end

  def get_token
    request_body = 
      {
        grant_type: ENV["EMPLOIES_API_GRANT_TYPE"],
        client_id: ENV["EMPLOIES_API_CLLIENT_ID"],
        client_secret: ENV["EMPLOIES_API_CLIENT_SECRET"],
        username: ENV["EMPLOIES_API_USERNAME"],
        password: ENV["EMPLOIES_API_PASSWORD"]
      }
      
    begin
      response = RestClient.post "#{URL_BASE_PATH}/token/", request_body
    rescue RestClient::ExceptionWithResponse => e
      return { status: e.response.code, error: e.response.body }
    rescue RestClient::Exception, SocketError, Errno::ECONNREFUSED => e
      return { status: 500, error: "Internal server error: #{e.exception.message}" }
    end

    return JSON.parse(response.body)["access_token"]
  end

  def get_data
    if @access_token
      headers = {
        Authorization: "Bearer #{@access_token}"
      }
      begin
        response = RestClient.get "#{URL_BASE_PATH}/employee/list", headers
        return { status: 200, data:  JSON.parse(response.body)}
      rescue RestClient::ExceptionWithResponse => e
        return { status: e.response.code, error: e.response.body }
      rescue RestClient::Exception, SocketError, Errno::ECONNREFUSED => e
        return { status: 500, error: "Internal server error: #{e.exception.message}" }
      end
    else
      return { status: 401, error: "No API access token"}
    end
  end
end