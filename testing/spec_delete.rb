require_relative 'spec_helper'

RSpec.describe 'DELETE' do

  app_cl = ApiClient.new
  
  context 'verify user with valid ID' do

    it 'can be deleted' do
      arr_id = UserController.show_users.map{ |user| user.id }
      response = app_cl.delete_user(arr_id.sample)
      expect(response.status).to eq(333)
    end

    it 'cannot be deleted twice' do
      arr_id = UserController.show_users.map{ |user| user.id }
      id = arr_id.sample
      app_cl.delete_user(id)
      response = app_cl.delete_user(id)
      expect(response.status).to eq(404)
    end
  end
  
end