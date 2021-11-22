require_relative 'spec_helper'

app_cl = ApiClient.new

RSpec.describe 'valid POST' do
  body = DataGeneration.valid_body

  context 'verify user can be posted' do
    it "with valid data #{body}" do
        response = app_cl.create_user(body)
        expect(response.status).to eq(333)
    end
  end
end

RSpec.shared_examples 'invalid POST' do |parameter, mess, data|
  context 'verify user cannot be posted' do
    data.each do |value|

      before(:each) { @body = DataGeneration.update_valid_body({ parameter => value }) }

      it "with parameter #{parameter} with #{value} and correct code received " do
        response = app_cl.create_user(@body) 
        expect(response.body.include?(mess)).to eq(true)
        expect(response.status).to eq(444)
      end
    end
  end

end


RSpec.describe 'POST' do
  ERR_POST[:for_str].each_pair do |key, value|
    include_examples 'invalid POST', :fname, key, value
    include_examples 'invalid POST', :lname, key, value
    include_examples 'invalid POST', :city, key, value
  end

  ERR_POST[:for_phone].each_pair do |key, value|
    include_examples 'invalid POST', :phone, key, value
  end

  ERR_POST[:for_age].each_pair do |key, value|
    include_examples 'invalid POST', :age, key, value
  end
end

