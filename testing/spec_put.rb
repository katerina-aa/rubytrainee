require_relative 'spec_helper'

app_cl = ApiClient.new

RSpec.shared_examples 'valid PUT' do |parameter, data|
  context 'verify user can be changed' do
    body = DataGenerator.new.empty_body.edit(parameter, data)
    it "with #{parameter} = #{data} and correct code received" do
      response = app_cl.update_user(@id, body)
      expect(response.status).to eq(333)
    end

    it "with #{parameter} = #{data} and record changed in DB" do
      app_cl.update_user(@id, body) 
      response = app_cl.get_user_by(parameter, body[parameter]) 
      expect(response.status).to eq(222)
    end
  end
end

RSpec.shared_examples 'invalid PUT' do |parameter, mess, data|
  context 'verify user cannot be changed' do
    data.each do |value|
      it "with parameter #{parameter} = #{value} and correct code received" do
        response = app_cl.update_user(@id, value)
        expect(response.body.include?(mess)).to eq(true)
        expect(response.status).to eq(444)
      end

      it "with #{parameter} = #{value} and no record in DB" do
        app_cl.update_user(@id, value)
        response = app_cl.get_user_by(parameter, value[parameter]) 
        expect(response.status).to eq(443)
      end
    end
  end
end

RSpec.describe 'PUT' do
  before(:each) do
    users_body = app_cl.get_all.body.gsub(/}{/, '}::{').split('::')
    @id = users_body.map{ |user| JSON.parse(user)["id"] }.sample
  end

  [:fname, :lname, :city].each do |param|
    DataGenerator.new.err_for_str(:empty_body, param).msg.each_pair do |key, value|
      include_examples 'invalid PUT', param, key, value
    end
  end

  DataGenerator.new.err_for_phone(:empty_body).msg.each_pair do |key, value|
    include_examples 'invalid PUT', :phone, key, value
  end
 
  DataGenerator.new.err_for_age(:empty_body).msg.each_pair do |key, value|
    include_examples 'invalid PUT', :age, key, value
  end

  DataGenerator.new.valid_body.opts.each do |key, value|
    include_examples 'valid PUT', key, value
  end
end