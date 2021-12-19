# frozen_string_literal: true

require_relative 'spec_helper'

# The ApiClient class is responsible for sending requests
class ApiClient
  def initialize
    @base_url = 'http://web:4567/'
  end

  def get_all(auth)
    app_request(:get, '/users', auth)
  end

  def get_user_by_id(id, auth)
    app_request(:get, "user/#{id}/get", auth)
  end

  def get_user_by(key, value, auth)
    app_request(:get, "user/#{key}/#{value}/get", auth)
  end

  def create_user(body, auth)
    app_request(:post, 'user/create', auth, body)
  end

  def update_user(id, body, auth)
    app_request(:patch, "user/#{id}/edit", auth, body)
  end

  def delete_user(id, auth)
    app_request(:delete, "user/#{id}/delete", auth)
  end

  private

  def app_request(type, url, auth, body = '')
    begin
      retries ||= 0
      @conn = Faraday.new(@base_url)
      @conn.request(:basic_auth, auth[:username], auth[:password])
      @conn.send(type, url) do |req|
        req.body = body unless body.empty?
        req.options.timeout = 5000
      end
    rescue TimeoutError
      retry if (retries += 1) < 5
    end
  end
end
