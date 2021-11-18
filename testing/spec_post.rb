require_relative 'spec_helper'

app_cl = ApiClient.new

RSpec.describe 'valid POST' do
  body = DataGeneration.valid_body

  context 'verify user can be posted' do
    it 'with valid data' do
        response = app_cl.create_user(body)
        expect(response.status).to eq(333)
    end
  end
end

RSpec.shared_examples 'invalid POST' do |parameter, mess, data|
  context 'verify user cannot be posted' do
    data.each do |value|
      it "with parameter #{parameter} with #{value}" do
        body = DataGeneration.update_valid_body( { parameter => value } )
        response = app_cl.create_user(body) 
        expect(response.body.include?(mess)).to eq(true)
        expect(response.status).to eq(444)
      end
    end
  end
end

err_for_str = {
  "can't be blank" => [''], 
  "has invalid length" => [ DataGeneration.letters_string(1), DataGeneration.letters_string(rand(21..50)) ], 
  "only allows letters" => [ DataGeneration.numbers_string(rand(2..20)), DataGeneration.symbols_string(rand(2..20)) ]
}
err_for_phone = {
  "can't be blank" => [''], 
  "has invalid length" => [ DataGeneration.numbers_string(rand(1..8)), DataGeneration.numbers_string(rand(14..20)) ],
  "is not a number" => [ DataGeneration.letters_string(rand(9..13)), DataGeneration.symbols_string(rand(9..13)) ]
}
err_for_age = {
  "can't be blank" => [''],
  "has invalid length" => [ DataGeneration.numbers_string(rand(4..20)) ],
  "is not a number" => [ DataGeneration.letters_string(rand(1..3)), DataGeneration.symbols_string(rand(1..3)) ]
}

RSpec.describe 'POST' do
  err_for_str.each_pair do |key, value|
    include_examples 'invalid POST', :fname, key, value
    include_examples 'invalid POST', :lname, key, value
    include_examples 'invalid POST', :city, key, value
  end

  err_for_phone.each_pair do |key, value|
    include_examples 'invalid POST', :phone, key, value
  end

  err_for_age.each_pair do |key, value|
    include_examples 'invalid POST', :age, key, value
  end
end

