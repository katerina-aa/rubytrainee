require_relative 'spec_helper'

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

ERR_PUT = { 
    for_str: err_for_str, 
    for_phone: err_for_phone, 
    for_age: err_for_age 
}
ERR_POST = { }

ERR_PUT.each_pair { |key, value|  ERR_POST.merge!( { key => value.merge({ "can't be blank" => [''] }) })}
