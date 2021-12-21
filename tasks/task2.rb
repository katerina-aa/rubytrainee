# frozen_string_literal: true

# Create class Vehicle
# Vehicle has year, model, owner and manufacturer
# Class should have following attributes:
# - attribute accessor: owner
# - attribute reader: year, model, manufacturer
# - class attribute: count of wheels, which is accessible to all of class instances(objects)
# Create three instances of Vehicle class:
# - Audi A3, 1979, owner - Antonio
# - Moskvych 412, 1988, no owner at the moment of Vehicle creation. After - set owner as Vlad
# - Skoda Fabia, 1990, owner - Tony
class Vehicle
  attr_accessor :owner
  attr_reader :year, :model, :manufacturer

  @@count_of_wheels = 4

  def initialize(owner, year, model, manufacturer)
    @owner = owner
    @year = year
    @model = model
    @manufacturer = manufacturer
  end

  def vehicle_info
    puts "Your car is #{@manufacturer} #{@model}, #{@year}, owner - #{@owner}. Your car has #{@@count_of_wheels} wheels."
  end

  def change_owner(owner)
    @owner = owner
  end
end

car1 = Vehicle.new('Antonio', 1979, 'A3', 'Audi')
car2 = Vehicle.new('no', 1988, '412', 'Moskvych')
car3 = Vehicle.new('Tony', 1990, '', 'Skoda Fabia')

car1.vehicle_info
car2.vehicle_info
car3.vehicle_info
car3.change_owner('Vlad')
car3.vehicle_info
