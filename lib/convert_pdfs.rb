class PartAssetConverter

  def initialize(attrs={})
    @attributes = attrs
  end

  def asset_id
    @asset_id ||= @attributes[:asset_id]
  end

  def field_name
    @field_name ||= @attributes[:field_name]
  end

  def file_path
    "new-%s-pdfs" % [self.field_name.to_s]
  end

  def assets
    @assets ||= PartAsset.find(:all,
                               :select => 'pa.part_id, pa.asset_id, a.*',
                               :from => 'part_assets pa',
                               :joins => 'LEFT JOIN assets a ON pa.asset_id = a.id',
                               :conditions => ['pa.part_asset_type_id = ?', self.asset_id])
  end

  def grouped_assets
    @grouped_assets ||= self.assets.group_by { |pa| pa.asset_file_name }.inject({}) do |hsh,res|
      hsh[res[1].first.asset.asset.path] = res[1]
      hsh
    end
  end

  def makedirs!
    path = File.join(Rails.root, 'public', 'system', self.file_path)
    cmd = "mkdir -p %s" % [path]
    system(cmd) unless File.exists?(path) && File.directory?(path)
  end

  def convert!
    self.makedirs!
    #Iterate through grouped, and move the asset itself into public/system/new-part-images
    if self.grouped_assets.any?
      self.grouped_assets.each do |pd|
        file_name = pd[0].split('/').last
        new_file_path = File.join(Rails.root, 'public', 'system', self.file_path, file_name)
        system_cmd = "cp %s %s" % [pd[0], new_file_path]
        puts "Executing %s" % [system_cmd]
        system(system_cmd)

        # Iterate through part attributes and update the photo field with the proper name
        parts = pd[1].map(&:part)
        if parts.any?
          parts.each do |part|
            part.update_attribute(self.field_name, file_name)
          end
        end
      end
    end
  end
end

module ConvertPdfs
  def self.convert!
    [Tech, Vbfix, Instructions, Announcement].map(&:convert!)
  end

  class Tech
    def self.convert!
      converter = PartAssetConverter.new(:asset_id => 4, :field_name => :tech)
      converter.convert!
    end
  end

  class Vbfix
    def self.convert!
      converter = PartAssetConverter.new(:asset_id => 5, :field_name => :vbfix)
      converter.convert!
    end
  end

  class Instructions
    def self.convert!
      converter = PartAssetConverter.new(:asset_id => 3, :field_name => :instructions)
      converter.convert!
    end
  end

  class Announcement
    def self.convert!
      converter = PartAssetConverter.new(:asset_id => 2, :field_name => :announcement)
      converter.convert!
    end
  end
end
