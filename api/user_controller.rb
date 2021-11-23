require_relative 'models'

class UserController 
    def self.show_users()
        # .map(&:to_s) --> when we do response - we need to give them strings, not objects
        # believe we have to work on this, either convert to json
        # anyway - check best practices on this
        User.all.map(&:to_s)
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
