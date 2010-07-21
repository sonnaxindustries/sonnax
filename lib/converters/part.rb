class Converters::Part < Part
  class << self
    def remove_orphaned_parts!
      #remove parts from product lines that aren't used anymore
    end
    
    def remove_reference_figure_parts!
      #remove the parts for the reference figures only
    end
    
    def run!
      # Here we want to take the old DB and get rid of records we don't need (clean up the old DB before importing)
      %w( parts part_attributes part_assets ).each do |table|
        statement = "TRUNCATE %s" % [table]
        ActiveRecord::Base.connection.execute(statement)
      end
      
      Legacy::Part.each do |part|
        params = {
        
        }
        
        new_part = self.create!(params)
        
        #Create the attributes table
        part.part_attributes.each do |attribute|
          if !attribute.attr_value.blank?
            new_part.part_attributes.create(:part_attribute_type => attribute.part_attribute_type, :attr_value => attribute.attr_value)
          end
        end
      end
    end
  end
end