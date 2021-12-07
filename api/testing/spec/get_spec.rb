# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Get request' do
  app_cl = ApiClient.new
  auth_data = { username: 'admin', password: 'admin' }

  before(:all) do
    @arr_users = Array.new(3) { JSON.parse(app_cl.create_user(DataGenerator.new.valid_body.opts, auth_data).body) }
    @arr_id = @arr_users.map { |user| user['id'] }
  end

  after(:all) do
    @arr_id.each { |id| app_cl.delete_user(id, auth_data) }
  end

  context 'when request to get all users' do
    it 'response code is 200' do
      response = app_cl.get_all(auth_data)
      expect(response.status).to eq(200)
    end

    it 'list of all users is returned' do
      users_body = JSON.parse(app_cl.get_all(auth_data).body)
      expect(@arr_users.all? { |elem| users_body.include?(elem) }).to eq(true)
    end
  end

  context 'when request to get user with valid ID' do
    it 'response code is 222' do
      response = app_cl.get_user_by_id(@arr_id.sample, auth_data)
      expect(response.status).to eq(222)
    end
  end

  context 'when request to get user with invalid ID' do
    it 'response code is 443' do
      id = @arr_id.sample
      app_cl.delete_user(id, auth_data)
      response = app_cl.get_user_by_id(id, auth_data)
      expect(response.status).to eq(443)
    end
  end
end
