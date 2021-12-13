# frozen_string_literal: true

require_relative '../spec_helper'

app_cl = ApiClient.new
auth_data = { username: 'admin', password: 'admin' }

RSpec.shared_examples 'invalid data' do |parameter, mess, data|
  data.each do |body|
    context "when request with invalid parameter #{parameter} = #{body[parameter]}" do
      it 'response code is 444' do
        response = app_cl.create_user(body, auth_data)
        expect(response.body.include?(mess)).to eq(true)
        expect(response.status).to eq(444)
      end

      it 'no record in DB' do
        app_cl.create_user(body, auth_data)
        response = app_cl.get_user_by(parameter, body[parameter], auth_data)
        expect(response.status).to eq(443)
      end
    end
  end
end

RSpec.describe 'Post request' do
  %i[fname lname city].each do |param|
    err_with_blank(err_for_str(:valid_body, param), param).each_pair do |key, value|
      include_examples 'invalid data', param, key, value
    end
  end

  err_with_blank(err_for_phone(:valid_body), :phone).each_pair do |key, value|
    include_examples 'invalid data', :phone, key, value
  end

  err_with_blank(err_for_age(:valid_body), :age).each_pair do |key, value|
    include_examples 'invalid data', :age, key, value
  end

  valid_body = DataGenerator.new.valid_body.opts

  context "when request with valid body #{valid_body}" do
    after(:each) { app_cl.delete_user(@id_for_post, auth_data) }

    it 'response code is 333' do
      response = app_cl.create_user(valid_body, auth_data)
      @id_for_post = JSON.parse(response.body)['id']
      expect(response.status).to eq(333)
    end

    it 'new record in DB' do
      user = app_cl.create_user(valid_body, auth_data).body
      @id_for_post = JSON.parse(user)['id']
      response = app_cl.get_user_by_id(@id_for_post, auth_data)
      expect(response.status).to eq(222)
    end
  end
end
