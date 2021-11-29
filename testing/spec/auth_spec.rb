# frozen_string_literal: true

require_relative '../spec_helper'
require 'securerandom'

app_cl = ApiClient.new

RSpec.shared_examples 'when invalid data is inserted' do |auth_data|
  context "Username: #{auth_data[:username]} and Password: #{auth_data[:password]}" do
    it 'response code is 401' do
      response = app_cl.get_all(auth_data)
      expect(response.status).to eq(401)
    end
  end
end

RSpec.describe 'Authorization' do
  context 'when valid Username and Password' do
    it 'response code is 200' do
      response = app_cl.get_all({ username: 'admin', password: 'admin' })
      expect(response.status).to eq(200)
    end
  end

  include_examples 'when invalid data is inserted', { username: SecureRandom.hex, password: 'admin' }
  include_examples 'when invalid data is inserted', { username: 'admin', password: SecureRandom.hex }
  include_examples 'when invalid data is inserted', { username: SecureRandom.hex, password: SecureRandom.hex }
end
