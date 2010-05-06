class Converters::UnitsMake < UnitsMake
  class << self
    def run!
      Legacy::UnitMake.all.each do |u|
        
        if u.create_record?
          puts "Importing for Unit: %s and Make: $s" % [u.unit.name, u.make.make]
          params = {
            :unit => u.unit._model_record,
            :make => u.make._model_record
          }
          
          self.create!(params)
        end
      end
    end
  end
end