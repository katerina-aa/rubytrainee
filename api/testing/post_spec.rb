require_relative 'spec_helper'

RSpec.describe 'POST' do

  app_cl = ApiClient.new
  body = app_cl.generate_random_body

  context 'verify user can post' do
    it 'with valid data' do
        response = app_cl.create_user(body)
        expect(response.status).to eq(333)
    end
  end

end