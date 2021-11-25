class DataGenerator
    def initialize()
        @opts = {}
        @msg = {}
    end

    def opts
        @opts
    end

    def msg
        @msg
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

    def err_for_str(body, key)
        @msg[ "has invalid length" ] = [ DataGenerator.new.send(body).with_letters(key, 1).opts, DataGenerator.new.send(body).with_letters(key, rand(21..50)).opts ]
        @msg[ "only allows letters" ] = [ DataGenerator.new.send(body).with_numbers(key, rand(2..20)).opts, DataGenerator.new.send(body).with_symbols(key, rand(2..20)).opts ]
        self
    end
    
    def err_for_phone(body) 
        @msg[ "has invalid length" ] = [ DataGenerator.new.send(body).with_numbers(:phone, rand(1..8)).opts, DataGenerator.new.send(body).with_numbers(:phone, rand(14..20)).opts ]
        @msg[ "is not a number" ] = [ DataGenerator.new.send(body).with_letters(:phone, rand(9..13)).opts, DataGenerator.new.send(body).with_symbols(:phone, rand(9..13)).opts ]
        self
    end

    def err_for_age(body)
        @msg[ "has invalid length" ] = [ DataGenerator.new.send(body).with_numbers(:age, rand(4..20)).opts ]
        @msg[ "is not a number" ] =  [ DataGenerator.new.send(body).with_letters(:age, rand(1..3)).opts, DataGenerator.new.send(body).with_symbols(:age, rand(1..3)).opts ]
        self
    end
    
    def err_blank(key)
        @msg[ "can't be blank" ] = [ DataGenerator.new.valid_body.with_empty_value(key).opts]
        self
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
        @opts[key] = ["!", "$", "&", "'", "(", ")", "*", "+", ",", ";", "="].sample(range).join
        self
    end
end
