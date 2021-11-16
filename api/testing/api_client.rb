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

  def generate_random_body
    {
        fname: generate_string(rand(2..20)),
        lname: generate_string(rand(2..20)),
        city: generate_string(rand(2..20)),
        phone: generate_number(rand(9..13)),
        age: generate_number(rand(1..3))
    }
  end

  def generate_string(range)
    charset = Array('A'..'Z') + Array('a'..'z')
    Array.new(range) { charset.sample }.join
  end

  def generate_number(range)
    Array.new(range) { rand(0..9) }.join
  end

  def create_user(body)
    app_request(:post, @base_url + "user/create", body)
  end

  def user_login(username, password)
    app_request(:get, @base_url, { username: username, password: password })
  end

  def update_user(id, body)
    app_request(:patch, @base_url + "user/#{id}/edit", body)
  end

  def delete_user(id)
    app_request(:delete, @base_url + "user/#{id}/delete")
  end

  def login_as_admin
    user_login(ADMIN, ADMIN)
  end

  private
  def app_request(type, url, body = nil)
    Faraday.send(type, url, body)
  end
end