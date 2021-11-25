require 'faraday'

class ApiClient

  def initialize()  
    @base_url = 'http://localhost:4567/'
  end

  def get_all()
    app_request(:get, @base_url + 'users/get')
  end

  def get_user_by_id(id)
    app_request(:get, @base_url + "user/#{id}/get")
  end

  def get_user_by(key, value)
    app_request(:get, @base_url + "user/#{key}/#{value}/get")
  end

  def create_user(body)
    app_request(:post, @base_url + "user/create", body)
  end

  def update_user(id, body)
    app_request(:patch, @base_url + "user/#{id}/edit", body)
  end

  def delete_user(id)
    app_request(:delete, @base_url + "user/#{id}/delete")
  end

  private
  def app_request(type, url, body = nil, auth = 'Basic YWRtaW46YWRtaW4=')
    Faraday.send(type, url) do |req|
      req.headers['Authorization'] = auth  
      req.body = body unless body.nil?
    end
  end
end