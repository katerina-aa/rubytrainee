require 'faraday'
require 'json'

class ApiClient
  APP_JS = 'application/json'
  ADMIN = 'admin'

  def initialize
    @base_url = 'http://localhost:4567/'
  end

  def get_all()
    app_request(:get, @base_url)
  end

  def get_user()
    app_request(:get, @base_url + "user/#{id}/create")
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
  def app_request(type, url, body = nil)
    Faraday.send(type, url, body)
  end
end