class Converters::Distributor < Distributor
  class << self
    def run!
      ActiveRecord::Base.connection.execute('TRUNCATE distributors')
      Legacy::Distributor.all.each do |r|
        r.determine_email_and_url!
        params = {
          :name => r.formatted_name,
          :city => r.city,
          :state => r.state,
          :country => r.country,
          :phone_number => r.phone,
          :website_url => r.formatted_url,
          :email => r.formatted_email,
          :has_multiple_locations => r.multiple_locations?
        }
        
        self.create!(params)
      end
    end
  end
end