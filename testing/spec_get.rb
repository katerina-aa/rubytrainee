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
    it 'can be got with valid ID' do
      response = app_cl.get_user(IdGenerator.valid_id)
      expect(response.status).to eq(222)
    end

    it 'cannot be got with invalid ID' do
      response = app_cl.get_user(IdGenerator.invalid_id)
      expect(response.status).to eq(443)
    end
  end
  
end