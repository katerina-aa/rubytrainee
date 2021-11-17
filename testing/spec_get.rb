require_relative 'spec_helper'

RSpec.describe 'GET' do

  app_cl = ApiClient.new
  
  context 'verify user can get' do
      it 'info about all user' do
        response = app_cl.get_all()
        expect(response.status).to eq(200)
    end
  end
  
end