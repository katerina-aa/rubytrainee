# frozen_string_literal: true

require_relative '../spec_helper'

app_cl = ApiClient.new
auth_data = { username: 'admin', password: 'admin' }

RSpec.shared_examples 'invalid' do |parameter, mess, data|
  data.each do |body|
    context "when request with invalid body #{body}" do
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
  [:fname, :lname, :city].each do |param|
    ErrorGenerator.new.err_for_str(:valid_body, param).err_blank(param).msg.each_pair do |key, value|
      include_examples 'invalid', param, key, value
    end
  end

  ErrorGenerator.new.err_for_phone(:valid_body).err_blank(:phone).msg.each_pair do |key, value|
    include_examples 'invalid', :phone, key, value
  end

  ErrorGenerator.new.err_for_age(:valid_body).err_blank(:age).msg.each_pair do |key, value|
    include_examples 'invalid', :age, key, value
  end

  valid_body = DataGenerator.new.valid_body.opts

  context "when request with valid body #{valid_body}" do
    it 'response code is 333' do
      response = app_cl.create_user(valid_body, auth_data)
      expect(response.status).to eq(333)
    end

    it 'new record in DB' do
      user = app_cl.create_user(valid_body, auth_data).body
      user_id = JSON.parse(user)['id']
      response = app_cl.get_user_by_id(user_id, auth_data)
      expect(response.status).to eq(222)
    end
  end
end
