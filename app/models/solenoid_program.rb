class SolenoidProgram < ActiveRecord::Base
  def validate
    self.errors.add(:name, 'Please provide your Name') unless self.name?
    self.errors.add(:company, 'Please provide your Company') unless self.company?
    self.errors.add(:address, 'Please provide your Address') unless self.address?
    self.errors.add(:city, 'Please provide your City') unless self.city?
    self.errors.add(:state, 'Please provide your State') unless self.state?
    self.errors.add(:postal_code, 'Please provide your Postal Code') unless self.postal_code?
    self.errors.add(:phone, 'Please provide your Phone Number') unless self.phone?
    self.errors.add(:number_of_cores, 'Please provide a number of cores') unless self.number_of_cores?
  end
end
