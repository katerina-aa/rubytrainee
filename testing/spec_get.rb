require_relative 'spec_helper'

RSpec.describe 'GET' do

  app_cl = ApiClient.new
  
  context 'verify info about all users' do
    it 'can be got' do
      response = app_cl.get_all()
      expect(response.status).to eq(200)
    end
  end

  context 'verify info about some user' do
    before(:each) do
      users_body = app_cl.get_all.body.gsub(/}{/, '}::{').split('::')
      @id = users_body.map{ |user| JSON.parse(user)["id"] }.sample
    end

    it 'can be got with valid ID' do
      response = app_cl.get_user_by_id(@id)
      expect(response.status).to eq(222)
    end

    it 'cannot be got with invalid ID' do
      app_cl.delete_user(@id)
      response = app_cl.get_user_by_id(@id)
      expect(response.status).to eq(443)
    end
  end
  
end