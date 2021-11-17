require_relative 'spec_helper'

RSpec.describe 'DELETE' do

  app_cl = ApiClient.new
  arr_id = UserControler.show_users.map{ |user| user.id }
  
  context 'verify user can delete' do
      it 'with valid ID' do
        response = app_cl.delete_user(arr_id.sample)
        expect(response.status).to eq(333)
    end
  end
  
end