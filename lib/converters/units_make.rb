class Converters::UnitsMake < UnitsMake
  class << self
    def run!
      Legacy::UnitMake.all.each do |u|
        params = {
          :login => u.un,
          :password => u.retrieve_password!,
          :password_confirmation => u.retrieve_password! 
        }
        
        self.create!(params)
      end
    end
  end
end