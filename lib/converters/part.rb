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
      %w( parts product_line_parts part_attributes part_assets ).each do |table|
        statement = "TRUNCATE %s" % [table]
        ActiveRecord::Base.connection.execute(statement)
      end
      
      Legacy::Part.list.each do |part|
        params = {
          :product_line_id  => part.product_line_id,
          :part_type        => part.part_type_object,
          :part_number      => part.part_number,
          :oem_part_number  => part.oem_part_number,
          :name             => part.name,
          :item             => part.item,
          :notes            => part.notes,
          :description      => part.description,
          :price            => part.price,
          :weight           => part.weight,
          :ref_code         => part.ref_code,
          :ref_code_sort    => part.ref_code_sort,
          :is_featured      => part.featured?
        }
        
        new_part = self.new(params)
        new_part.save!
        
        #add the photo
        puts "Checking for the product photo..."
        if part.photo_file?
          asset = Asset.find_by_asset_file_name(File.basename(part.photo_filename))
          
          if !asset.blank?
            new_part.part_assets.create(:part_asset_type => PartAssetType.photo, :asset => asset, :name => part.name, :description => part.description)
          end
        end

        #Create the attributes table
        puts "Checking for attributes..."
        part.part_attributes.each do |a|
          if !a.attr_value.blank?
            puts "Adding attribute %s for %s..." % [a.part_attribute_type.name, part.part_number]
            new_part.part_attributes.create(:part_attribute_type => a.part_attribute_type, :attr_value => a.attr_value)
          else
            puts "No attribute value found for %s" % [part.part_number]
          end
        end
        
        #Create the assets table
        # part.part_assets.each do |asset|
        #   if !asset.file.blank?
        #     new_part.part_assets.create(:part_asset_type => attribute.part_asset_type, :asset => attribute.asset)
        #   end
        # end
      end
    end
  end
end