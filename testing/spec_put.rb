require_relative 'spec_helper'

app_cl = ApiClient.new

RSpec.shared_examples 'valid PUT' do |parameter, data|
  context 'verify user can be changed' do
    it "with parameter #{parameter} with #{data}" do
      body = DataGeneration.update_empty_body( { parameter => data } )
      arr_id = UserController.show_users.map{ |user| user.id }
      response = app_cl.update_user(arr_id.sample, body)
      expect(response.status).to eq(333)
    end
  end
end

RSpec.shared_examples 'invalid PUT' do |parameter, mess, data|
  context 'verify user cannot be changed' do
    data.each do |value|
      it "with parameter #{parameter} with #{value}" do
        body = DataGeneration.update_empty_body( { parameter => value } )
        arr_id = UserController.show_users.map{ |user| user.id }
        response = app_cl.update_user(arr_id.sample, body)
        expect(response.body.include?(mess)).to eq(true)
        expect(response.status).to eq(444)
      end
    end
  end
end

err_for_str = {
  "has invalid length" => [ DataGeneration.letters_string(1), DataGeneration.letters_string(rand(21..50)) ], 
  "only allows letters" => [ DataGeneration.numbers_string(rand(2..20)), DataGeneration.symbols_string(rand(2..20)) ]
}
err_for_phone = {
  "has invalid length" => [ DataGeneration.numbers_string(rand(1..8)), DataGeneration.numbers_string(rand(14..20)) ],
  "is not a number" => [ DataGeneration.letters_string(rand(9..13)), DataGeneration.symbols_string(rand(9..13)) ]
}
err_for_age = {
  "has invalid length" => [ DataGeneration.numbers_string(rand(4..20)) ],
  "is not a number" => [ DataGeneration.letters_string(rand(1..3)), DataGeneration.symbols_string(rand(1..3)) ]
}
body = DataGeneration.valid_body

RSpec.describe 'PUT' do
 
  err_for_str.each_pair do |key, value|
    include_examples 'invalid PUT', :fname, key, value
    include_examples 'invalid PUT', :lname, key, value
    include_examples 'invalid PUT', :city, key, value
  end

  err_for_phone.each_pair do |key, value|
    include_examples 'invalid PUT', :phone, key, value
  end

  err_for_age.each_pair do |key, value|
    include_examples 'invalid PUT', :age, key, value
  end

  body.each_pair do |key, value|
    include_examples 'valid PUT', key, value
  end

end