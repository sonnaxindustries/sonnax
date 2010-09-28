class Converters::PartPhoto < PartPhoto
  class << self
    def run!
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