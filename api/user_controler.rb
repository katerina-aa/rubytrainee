require_relative 'models'

class UserControler 
    def self.show_users()
       User.all
    end

    def self.get_user(id_value)
        User.find_by_id(id_value)
    end

    def self.create_user(opts)
        User.create(opts)
    end
   
    def self.delete_user(id_value)  
        User.destroy_by(id: id_value)
    end
      
    def self.edit_user(id_value, opts) 
        @user = get_user(id_value)
        opts.each_pair { |key, value| @user.send("#{key}=", value) unless value.empty? }
        @user.save 
        @user
    end

end
