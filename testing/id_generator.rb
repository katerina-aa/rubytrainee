require_relative 'spec_helper'

module IdGenerator
    def self.valid_id
        UserController.show_users.map{ |user| user.id }.sample
    end

    def self.invalid_id
        arr_id = UserController.show_users.map{ |user| user.id }
        id = rand(1000) 
        id = rand(1000) while arr_id.any? id
        id
    end
end

