# frozen_string_literal: true

require_relative '../spec_helper'

RSpec.describe 'Delete request' do
  app_cl = ApiClient.new
  auth_data = { username: 'admin', password: 'admin' }

  before(:all) do
    @users_for_delete = Array.new(3) { JSON.parse(app_cl.create_user(DataGenerator.new.valid_body.opts, auth_data).body) }
    @id_for_delete = @users_for_delete.map { |user| user['id'] }
  end

  after(:all) { @id_for_delete.each { |id| app_cl.delete_user(id, auth_data) } }

  before(:each) { @rand_id = @id_for_delete.sample }

  context 'when request with valid ID' do
    it 'response code is 333' do
      response = app_cl.delete_user(@rand_id, auth_data)
      expect(response.status).to eq(333)
    end

    it 'user is deleted in DB' do
      app_cl.delete_user(@rand_id, auth_data)
      response = app_cl.get_user_by_id(@rand_id, auth_data)
      expect(response.status).to eq(443)
    end
  end

  context 'when request is sent twice' do
    it 'response code is 443' do
      app_cl.delete_user(@rand_id, auth_data)
      response = app_cl.delete_user(@rand_id, auth_data)
      expect(response.status).to eq(443)
      expect(response.body.include?('Something works wrong')).to eq(true)
    end
  end

  inv_id = invalid_id
  context "when request with invalid ID(not number) = #{inv_id}" do
    it 'response code is 443' do
      response = app_cl.delete_user(inv_id, auth_data)
      expect(response.status).to eq(443)
      expect(response.body.include?('Something works wrong')).to eq(true)
    end
  end
end
