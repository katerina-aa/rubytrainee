require_relative 'spec_helper'

RSpec.describe 'PUT' do

  app_cl = ApiClient.new
  body = DataGeneration.valid_body
  arr_id = UserControler.show_users.map{ |user| user.id }

  context 'verify user can put' do
    it 'with valid ID and valid data' do
        response = app_cl.update_user(arr_id.sample, body)
        expect(response.status).to eq(333)
    end
  end

end