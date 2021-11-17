class DataGeneration
    def self.generate_random_body
        {
            fname: generate_string(rand(2..20)),
            lname: generate_string(rand(2..20)),
            city: generate_string(rand(2..20)),
            phone: generate_number(rand(9..13)),
            age: generate_number(rand(1..3))
        }
    end
    
    def self.generate_string(range)
        charset = Array('A'..'Z') + Array('a'..'z')
        Array.new(range) { charset.sample }.join
    end

    def self.generate_number(range)
        Array.new(range) { rand(0..9) }.join
    end
end