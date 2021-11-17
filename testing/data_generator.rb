class DataGeneration
    def self.valid_body
        {
            fname: letters_string(rand(2..20)),
            lname: letters_string(rand(2..20)),
            city: letters_string(rand(2..20)),
            phone: numbers_string(rand(9..13)),
            age: numbers_string(rand(1..3))
        }
    end
    
    def self.letters_string(range)
        charset = Array('A'..'Z') + Array('a'..'z')
        Array.new(range) { charset.sample }.join
    end

    def self.numbers_string(range)
        Array.new(range) { rand(0..9) }.join
    end

    def self.symbols_string(range)
        symbols = ["!", "#", "$", "%", "&", "’", "*", "+", "-", "/", "=", "?", "^", "_", "{", "|", "}", "~", ",", ".", "(", ")"]
        Array.new(range) { symbols.sample }.join
    end

    def self.update_body(opts)
        valid_body.merge(opts)
    end

end