require_relative 'spec_helper'

app_cl = ApiClient.new
body = DataGeneration.valid_body

RSpec.shared_examples 'valid PUT' do |parameter, data|
  context 'verify user can be changed' do
    it "with parameter #{parameter} with #{data}" do
      body = DataGeneration.update_empty_body( { parameter => data } )
      response = app_cl.update_user(@id, body)
      expect(response.status).to eq(333)
    end
  end
end

RSpec.shared_examples 'invalid PUT' do |parameter, mess, data|
  context 'verify user cannot be changed' do
    data.each do |value|
      it "with parameter #{parameter} with #{value}" do
        body = DataGeneration.update_empty_body( { parameter => value } )
        response = app_cl.update_user(@id, body)
        expect(response.body.include?(mess)).to eq(true)
        expect(response.status).to eq(444)
      end
    end
  end
end

RSpec.describe 'PUT' do
  before(:each) { @id = IdGenerator.valid_id }

  ERR_PUT[:for_str].each_pair do |key, value|
    include_examples 'invalid PUT', :fname, key, value
    include_examples 'invalid PUT', :lname, key, value
    include_examples 'invalid PUT', :city, key, value
  end

  ERR_PUT[:for_phone].each_pair do |key, value|
    include_examples 'invalid PUT', :phone, key, value
  end

  ERR_PUT[:for_age].each_pair do |key, value|
    include_examples 'invalid PUT', :age, key, value
  end

  body.each_pair do |key, value|
    include_examples 'valid PUT', key, value
  end
end