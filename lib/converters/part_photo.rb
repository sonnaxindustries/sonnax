class Converters::PartPhoto < PartPhoto
  class << self
    def run!
      #ActiveRecord::Base.connection.execute("DELETE FROM assets WHERE asset_content_type IN ('image/jpeg')")
      PartPhoto.photos.map(&:destroy)
      Legacy::Part.part_photos.each do |r|
        
        if File.exists?(r.filename)
          params = {
            :asset => File.open(r.filename)
          }

          self.create!(params)
        end
        
      end
    end
  end
end