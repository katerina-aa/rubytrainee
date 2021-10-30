=begin
Create class Vehicle
Vehicle has year, model, owner and manufacturer
Class should have following attributes:
- attribute accessor: owner
- attribute reader: year, model, manufacturer
- class attribute: count of wheels, which is accessible to all of class instances(objects)
Create three instances of Vehicle class:
- Audi A3, 1979, owner - Antonio
- Moskvych 412, 1988, no owner at the moment of Vehicle creation. After - set owner as Vlad
- Skoda Fabia, 1990, owner - Tony
=end

class Vehicle
    attr_accessor :owner
    attr_reader :year, :model, :manufacturer


    
end