# frozen_string_literal: true

require_relative 'spec_helper'

# The ErrorGenerator class is responsible for generating error messages
class ErrorGenerator
    attr_reader :msg

    def initialize
        @msg = {}
    end

    def err_for_str(body, key)
        valid_length = rand(2..20)
        @msg['has invalid length'] = [DataGenerator.new.send(body).with_letters(key, 1).opts, DataGenerator.new.send(body).with_letters(key, rand(21..50)).opts]
        @msg['only allows letters'] = [DataGenerator.new.send(body).with_numbers(key, valid_length).opts, DataGenerator.new.send(body).with_symbols(key, valid_length).opts]

        self
    end

    def err_for_phone(body)
        valid_length = rand(9..13)
        @msg['has invalid length'] = [DataGenerator.new.send(body).with_numbers(:phone, rand(1..8)).opts, DataGenerator.new.send(body).with_numbers(:phone, rand(14..20)).opts]
        @msg['is not a number'] = [DataGenerator.new.send(body).with_letters(:phone, valid_length).opts, DataGenerator.new.send(body).with_symbols(:phone, valid_length).opts]
        self
    end

    def err_for_age(body)
        valid_length = rand(1..3)
        @msg['has invalid length'] = [DataGenerator.new.send(body).with_numbers(:age, rand(4..20)).opts]
        @msg['is not a number'] =  [DataGenerator.new.send(body).with_letters(:age, valid_length).opts, DataGenerator.new.send(body).with_symbols(:age, valid_length).opts]
        self
    end

    def err_blank(key)
        @msg['can\'t be blank'] = [DataGenerator.new.valid_body.with_empty_value(key).opts]
        self
    end
end
