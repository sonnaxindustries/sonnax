require 'ostruct'
class CatalogRequest < ActiveRecord::Base  
  serialize :catalogs_hash, Array
  
  class << self
    def catalogs
      OpenStruct.new(self.catalogs_hash)
    end
    
    def catalogs_hash
      {
        :ts_volume_8 => "Transmission Products Catalog, Volume 8",
        :ts_volume_8_cd => "Transmission Products Catalog, Volume 8 on CD",
        :torque_converter_catalog => "Torque Converter Parts Catalog, Volume 6",
        :valve_body_training => "Valve Body Training DVD",
        :pts_catalog => "PowerTrainSavers<sup>&reg;</sup> Catalog, 2009",
        :driveline_catalog => "Driveline Catalog, Volume 3",
        :hd_catalog => "Harley Davidson<sup>&reg;</sup> Catalog",
        :transmission_report => "Transmission Report"
      }
    end
  end
  
  def validate
    self.errors.add(:name, 'Please provide a name') unless self.name?
    self.errors.add(:company, 'Please provide a company name') unless self.company?
    self.errors.add(:type_of_business, 'Please provide your type of business') unless self.type_of_business?
    self.errors.add(:address, 'Please provide your address') unless self.address?
    self.errors.add(:city, 'Please provide your city') unless self.city?
    self.errors.add(:state, 'Please provide your state') unless self.state?
    self.errors.add(:postal_code, 'Please provide your postal code') unless self.postal_code?
    self.errors.add(:country, 'Please provide your country') unless self.country?
    self.errors.add(:phone_number, 'Please provide your phone number') unless self.phone_number?
    self.errors.add(:email_address, 'Please provide your email address') unless self.email_address?
    self.errors.add(:catalogs_hash, 'Please select at least one catalog') unless self.catalogs?
  end
  
  def catalogs?
    !self.catalogs_hash.blank?
  end
  
  alias :catalogs_hash? :catalogs?
  
  def after_initialize
    self.catalogs_hash = [] unless self.catalogs_hash?
  end
end
