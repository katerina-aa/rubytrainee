require_relative 'models'

class UserController 
    def self.show_users()
        # believe we have to work on this, either convert to json
        # anyway - check best practices on this
        # User.all.map(&:to_s) will work
        # currently u return objects of class
        # and sinatra has no idea how to return them as string in response
        # u have to return string, json, or smth else
        User.all
    end
    
    def self.get_user(id_value)
        User.find_by_id(id_value)
    end

    def self.create_user(opts)
        User.create(opts)
    end
   
    def self.delete_user(id_value)
        user = get_user(id_value)
        user ? user.destroy : nil
    end
      
    def self.edit_user(id_value, opts) 
        @user = get_user(id_value)
        opts.each_pair { |key, value| @user.send("#{key}=", value) unless value.empty? }
        @user.save 
        @user
    end

end
