require 'digest/sha1'

class Converters::User < User
  class << self
    def run!
      Legacy::User.all.each do |u|
        params = {
          :login => u.un,
          :password => u.retrieve_password!,
          :password_confirmation => u.retrieve_password! 
        }
        
        roles = []
        
        if u.b_edit_users?
          roles << Role.edit_users
        end
        
        if u.b_edit_parts?
          roles << Role.edit_parts
        end
        
        if u.b_edit_makes?
          roles << Role.edit_makes
        end
        
        if u.b_edit_ref_figures?
          roles << Role.edit_reference_figures
        end
        
        if u.b_edit_distributors?
          roles << Role.edit_distributors
        end
        
        params.merge!(:roles => roles)
        
        self.create!(params)
      end
    end
  end
end