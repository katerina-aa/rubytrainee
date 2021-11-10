require_relative 'models'
require 'sinatra/activerecord'

class UserControler 
    def self.show_users()
       User.all
    end

    def self.create_user(hh)
        @user = User.create(hh)
    end
   
    def self.delete_user(id_value)  
        @user = User.find_by(id: id_value)
        @user.destroy
    end
      
    def self.edit_user(id_value, hh) 
        @user = User.find_by_id(id_value)
        hh.each_pair { |key, value| @user.send("#{key}=", value) unless value.empty?}
        @user.save 
    end
end
