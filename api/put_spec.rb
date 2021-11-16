require_relative 'testing/spec_helper'

RSpec.describe 'PUT' do

  app_cl = ApiClient.new
  body = app_cl.generate_random_body
  arr_id = UserControler.get_all_id()

  context 'verify user can put' do
    it 'with valid ID and valid data' do
        response = app_cl.update_user(arr_id.sample, body)
        expect(response.status).to eq(333)
    end
  end

end