# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Delete request' do
  app_cl = ApiClient.new
  auth_data = { username: 'admin', password: 'admin' }

  before(:all) do
    @arr_users = Array.new(3) { JSON.parse(app_cl.create_user(DataGenerator.new.valid_body.opts, auth_data).body) }
    @arr_id = @arr_users.map { |user| user['id'] }
  end

  after(:all) { @arr_id.each { |id| app_cl.delete_user(id, auth_data) } }

  before(:each) { @id = @arr_id.sample }

  context 'when request with valid ID' do
    it 'response code is 333' do
      response = app_cl.delete_user(@id, auth_data)
      expect(response.status).to eq(333)
    end

    it 'user is deleted in DB' do
      app_cl.delete_user(@id, auth_data)
      response = app_cl.get_user_by_id(@id, auth_data)
      expect(response.status).to eq(443)
    end
  end

  context 'when request is sent twice' do
    it 'response code is 443' do
      app_cl.delete_user(@id, auth_data)
      response = app_cl.delete_user(@id, auth_data)
      expect(response.status).to eq(443)
    end
  end
end
