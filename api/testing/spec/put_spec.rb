# frozen_string_literal: true

require_relative '../spec_helper'

app_cl = ApiClient.new
auth_data = { username: 'admin', password: 'admin' }

RSpec.shared_examples 'valid' do |parameter, data|
  body = DataGenerator.new.empty_body.edit(parameter, data)
  context "when request with #{parameter} = #{data}" do
    it 'response code is 333' do
      response = app_cl.update_user(@id, body, auth_data)
      expect(response.status).to eq(333)
    end

    it 'record changed in DB' do
      app_cl.update_user(@id, body, auth_data)
      response = app_cl.get_user_by(parameter, body[parameter], auth_data)
      expect(response.status).to eq(222)
    end
  end
end

RSpec.shared_examples 'invalid' do |parameter, mess, data|
  data.each do |value|
    context "when request with parameter #{parameter} = #{value[parameter]}" do
      it 'response code is 444' do
        response = app_cl.update_user(@id, value, auth_data)
        expect(response.body.include?(mess)).to eq(true)
        expect(response.status).to eq(444)
      end

      it 'no changes in DB' do
        app_cl.update_user(@id, value, auth_data)
        response = app_cl.get_user_by(parameter, value[parameter], auth_data)
        expect(response.status).to eq(443)
      end
    end
  end
end

RSpec.describe 'Put request' do
  before(:all) do
    @arr_users = Array.new(3) { JSON.parse(app_cl.create_user(DataGenerator.new.valid_body.opts, auth_data).body) }
    @arr_id = @arr_users.map { |user| user['id'] }
  end

  after(:all) do
    @arr_id.each { |id| app_cl.delete_user(id, auth_data) }
  end

  before(:each) do
    @id = @arr_id.sample
  end

  %i[fname lname city].each do |param|
    err_for_str(:empty_body, param).each_pair do |key, value|
      include_examples 'invalid', param, key, value
    end
  end

  err_for_phone(:empty_body).each_pair do |key, value|
    include_examples 'invalid', :phone, key, value
  end

  err_for_age(:empty_body).each_pair do |key, value|
    include_examples 'invalid', :age, key, value
  end

  DataGenerator.new.valid_body.opts.each do |key, value|
    include_examples 'valid', key, value
  end

  context 'when request with empty body' do
    body = DataGenerator.new.empty_body.opts
    it 'response code is 445' do
      response = app_cl.update_user(@id, body, auth_data)
      expect(response.body.include?('Nothing to change')).to eq(true)
      expect(response.status).to eq(445)
    end

    it 'no changes in DB' do
      app_cl.update_user(@id, body, auth_data)
      user = app_cl.get_user_by_id(@id, auth_data).body
      response = JSON.parse(user)
      expect(response.value?('')).to eq(false)
    end
  end

  context 'when request with non-existing ID' do
    it 'response code is 445' do
      app_cl.delete_user(@id, auth_data)
      response = app_cl.update_user(@id, DataGenerator.new.valid_body.opts, auth_data)
      expect(response.status).to eq(445)
      expect(response.body.include?('Nothing to change')).to eq(true)
    end
  end

  inv_id = invalid_id
  context "when request with invalid ID(not number) = #{inv_id}" do
    it 'response code is 445' do
      response = app_cl.update_user(inv_id, DataGenerator.new.valid_body.opts, auth_data)
      expect(response.status).to eq(445)
      expect(response.body.include?('Nothing to change')).to eq(true)
    end
  end
end
