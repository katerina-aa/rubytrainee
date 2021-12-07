# frozen_string_literal: true

require_relative 'data_generator'

def err_for_str(body, key)
  valid_length = rand(2..20)
  {
    'has invalid length' => [DataGenerator.new.send(body).with_letters(key, 1).opts, DataGenerator.new.send(body).with_letters(key, rand(21..50)).opts],
    'only allows letters' => [DataGenerator.new.send(body).with_numbers(key, valid_length).opts, DataGenerator.new.send(body).with_symbols(key, valid_length).opts]
  }
end

def err_for_phone(body)
  valid_length = rand(9..13)
  {
    'has invalid length' => [DataGenerator.new.send(body).with_numbers(:phone, rand(1..8)).opts, DataGenerator.new.send(body).with_numbers(:phone, rand(14..20)).opts],
    'is not a number' => [DataGenerator.new.send(body).with_letters(:phone, valid_length).opts, DataGenerator.new.send(body).with_symbols(:phone, valid_length).opts]
  }
end

def err_for_age(body)
  valid_length = rand(1..3)
  {
    'has invalid length' => [DataGenerator.new.send(body).with_numbers(:age, rand(4..20)).opts],
    'is not a number' => [DataGenerator.new.send(body).with_letters(:age, valid_length).opts, DataGenerator.new.send(body).with_symbols(:age, valid_length).opts]
  }
end

def err_with_blank(hh_err, key)
  hh_err.merge({ 'can\'t be blank' => [DataGenerator.new.valid_body.with_empty_value(key).opts] })
end

def invalid_id
  (Array('A'..'Z') + Array('a'..'z')).sample(rand(1..20)).join
end
