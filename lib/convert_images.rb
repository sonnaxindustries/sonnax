class ConvertImages

  class << self
    def convert!
      klass = self.new
      klass.convert!
    end
  end

  def assets
    @assets ||= PartAsset.find(:all,
                                  :select => 'pa.part_id, pa.asset_id, a.*',
                                  :from => 'part_assets pa',
                                  :joins => 'LEFT JOIN assets a ON pa.asset_id = a.id',
                                  :conditions => 'pa.part_asset_type_id = 1')
  end

  def grouped_assets
    @grouped_assets ||= self.assets.group_by { |pa| pa.asset_file_name }.inject({}) do |hsh,res|
      hsh[res[1].first.asset.asset.path] = res[1]
      hsh
    end
  end

  def makedirs!
    path = File.join(Rails.root, 'public', 'system', 'new-part-images')
    cmd = "mkdir -p %s" % [path]
    system(cmd)
  end

  def convert!
    self.makedirs!
    #Iterate through grouped, and move the asset itself into public/system/new-part-images
    if self.grouped_assets.any?
      self.grouped_assets.each do |pd|
        file_name = pd[0].split('/').last
        new_file_path = File.join(Rails.root, 'public', 'system', 'new-part-images', file_name)
        system_cmd = "cp %s %s" % [pd[0], new_file_path]
        puts "Executing %s" % [system_cmd]
        system(system_cmd)

        # Iterate through part attributes and update the photo field with the proper name
        parts = pd[1].map(&:part)
        if parts.any?
          parts.each do |part|
            part.update_attributes(:photo => file_name)
          end
        end
      end
    end
  end
end
