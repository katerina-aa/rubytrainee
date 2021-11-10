class User < ActiveRecord::Base  
    validates :fname, :lname, :city, format: { with: /\A[a-zA-Z]+\z/, message: "only allows letters" }
    validates :fname, :lname, :city, length: { in: 2..20, message: "has invalid length" }
    validates :age, :phone, numericality: { only_integer: true }
    validates :age, length: { in: 1..3, message: "has invalid length" }
    validates :phone, length: { is: 10, message: "has invalid length" }
    validates :fname, :lname, :city, :age, :phone, presence: true, on: :create
end

class Auth < ActiveRecord::Base
    
end