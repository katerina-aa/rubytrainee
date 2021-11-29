# frozen_string_literal: true

require 'sinatra/activerecord'

# The User class is responsible for creating User table
class User < ActiveRecord::Base
    validates :fname, :lname, :city, format: { with: /\A[a-zA-Z]+\z/, message: 'only allows letters' }
    validates :fname, :lname, :city, length: { in: 2..20, message: 'has invalid length' }
    validates :age, :phone, numericality: { only_integer: true }
    validates :age, length: { in: 1..3, message: 'has invalid length' }
    validates :phone, length: { in: 9..13, message: 'has invalid length' }
    validates :fname, :lname, :city, :age, :phone, presence: true, on: :create
end

# The Auth class is responsible for creating Auth table
class Auth < ActiveRecord::Base
end
