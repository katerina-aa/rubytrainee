require_relative 'spec_helper'

app_cl = ApiClient.new

RSpec.describe 'valid POST' do
  context 'verify user can be posted' do
    body = DataGenerator.new.valid_body.opts
    it "with valid data #{body} and correct code received" do
      response = app_cl.create_user(body)  
      expect(response.status).to eq(333)
    end

    it "with valid data #{body} and new record in DB" do
      user = app_cl.create_user(body).body
      user_id = JSON.parse(user)["id"]
      response = app_cl.get_user_by_id(user_id)
      expect(response.status).to eq(222)
    end
  end
end

RSpec.shared_examples 'invalid POST' do |parameter, mess, data|
  context 'verify user cannot be posted' do
    data.each do |body|
      it "with #{parameter} = #{body[parameter]} and correct code received" do
        response = app_cl.create_user(body) 
        expect(response.body.include?(mess)).to eq(true)
        expect(response.status).to eq(444)
      end

      it "with #{parameter} = #{body[parameter]} and no record in DB" do
        app_cl.create_user(body) 
        response = app_cl.get_user_by(parameter, body[parameter]) 
        expect(response.status).to eq(443)
      end
    end
  end
end

RSpec.describe 'POST' do
  [:fname, :lname, :city].each do |param|
    DataGenerator.new.err_for_str(:valid_body, param).err_blank(param).msg.each_pair do |key, value|
      include_examples 'invalid POST', param, key, value
    end
  end

  DataGenerator.new.err_for_phone(:valid_body).err_blank(:phone).msg.each_pair do |key, value|
    include_examples 'invalid POST', :phone, key, value
  end
 
  DataGenerator.new.err_for_age(:valid_body).err_blank(:age).msg.each_pair do |key, value|
    include_examples 'invalid POST', :age, key, value
  end
end

