class Converters::Distributor < Distributor
  class << self
    def run!
      Legacy::Distributor.all.each do |r|
        params = {
          :name => r.name,
          :city => r.city,
          :state => r.state,
          :country => r.country,
          :phone_number => r.phone,
          :website_url => r.url
        }
        
        self.create!(params)
      end
    end
  end
end