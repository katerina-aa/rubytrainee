require_relative 'spec_helper'

app_cl = ApiClient.new

RSpec.describe 'valid POST' do
  body = DataGeneration.valid_body

  context 'verify user can post' do
    it 'with valid data' do
        response = app_cl.create_user(body)
        expect(response.status).to eq(333)
    end
  end
end

RSpec.shared_examples 'invalid data' do |parameter, data|
  it "with parameter :#{parameter} with #{data}" do
    body = DataGeneration.update_body( { parameter => data } )
    response = app_cl.create_user(body)  
    expect(response.status).to eq(444)
  end
end

inval_for_str = ['', DataGeneration.letters_string(1), DataGeneration.letters_string(rand(21..50)), DataGeneration.numbers_string(rand(2..20)), DataGeneration.symbols_string(rand(2..20))]
inval_for_phone = ['', DataGeneration.numbers_string(rand(1..8)), DataGeneration.numbers_string(rand(14..20)), DataGeneration.letters_string(rand(9..13)), DataGeneration.symbols_string(rand(9..13))]
inval_for_age = ['', DataGeneration.numbers_string(rand(4..20)), DataGeneration.letters_string(rand(1..3)), DataGeneration.symbols_string(rand(1..3))]

RSpec.describe 'POST' do
  inval_for_str.each do |elem|
    include_examples 'invalid data', :fname, elem
    include_examples 'invalid data', :lname, elem
    include_examples 'invalid data', :city, elem
  end

  inval_for_phone.each do |elem|
    include_examples 'invalid data', :phone, elem
  end

  inval_for_age.each do |elem|
    include_examples 'invalid data', :age, elem
  end
end

