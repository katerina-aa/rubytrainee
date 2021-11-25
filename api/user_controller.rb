require_relative 'models'
require 'json'

class UserController 
    def self.get_all()
        User.all.map(&:to_json)
    end

    def self.get_user_by_id(id_value)
        User.find_by_id(id_value)
    end

    def self.get_user_by(key, value)
        User.find_by(key => value)
    end

    def self.create_user(opts)
        User.create(opts)
    end
   
    def self.delete_user(id_value)
        user = User.find_by_id(id_value)
        user ? user.destroy : nil
    end
      
    def self.edit_user(id_value, opts) 
        @user = User.find_by_id(id_value)
        counter = 0
        opts.each_pair do |key, value| 
            @user.send("#{key}=", value) unless value.empty? 
            counter += 1 if value == ''
        end
        @user.save 
        return '' if counter == opts.size
        @user
    end

end
