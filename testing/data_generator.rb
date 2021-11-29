# frozen_string_literal: true

# The DataGenerator class is responsible for generating test data
class DataGenerator
    attr_reader :opts

    def initialize
        @opts = {}
    end

    def valid_body
        [:fname, :lname, :city].each { |key| with_letters(key, rand(2..20)) }
        with_numbers(:phone, rand(9..13))
        with_numbers(:age, rand(1..3))
        self
    end

    def empty_body
        [:fname, :lname, :city, :phone, :age].each { |key| with_empty_value(key) }
        self
    end

    def edit(key, value)
        @opts[key] = value
        @opts
    end

    def with_empty_value(key)
        @opts[key] = ''
        self
    end

    def with_letters(key, range)
        @opts[key] = (Array('A'..'Z') + Array('a'..'z')).sample(range).join
        self
    end

    def with_numbers(key, range)
        @opts[key] = Array.new(range) { rand(0..9) }.join
        self
    end

    def with_symbols(key, range)
        @opts[key] = ['!', '$', '&', '\'', '(', ')', '*', '+', ',', ';', '='].sample(range).join
        self
    end
end
