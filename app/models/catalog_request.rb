require 'ostruct'
class CatalogRequest < ActiveRecord::Base  
  attr_accessor :catalogs, :catalogs_collection
  
  def initialize(attributes={})
    self.catalogs_collection = []
    super(attributes)
  end
  
  class << self
    def catalogs
      OpenStruct.new(self.catalogs_hash)
    end
    
    def catalogs_hash
      {
        :ts_volume_7 => "Transmission Specialties&reg; Catalog, Volume 7 on CD",
        :ts_diagnostic_guide => "Transmission Specialties Diagnostic Guide",
        :valve_body_training => "Valve Body Training DVD",
        :ts_new_product_advisory => "Transmission Specialties New Product Advisory",
        :allison_replacement_parts => "Allison Replacement Parts",
        :pts_catalog => "PowerTrainSavers&reg; Catalog, 2009",
        :driveline_brochure => "Driveline Brochure",
        :hd_catalog => "Harley Davidson&reg; Catalog",
        :rg_spec_sheet => "Ring Gear Spec Sheet",
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
    self.errors.add(:catalogs, 'Please select at least one catalog') unless self.catalogs?
  end
  
  def catalogs=(val)
    if val.blank?
      self.catalogs_collection = []
    else
      self.catalogs_collection << val unless self.catalogs_collection.include?(val)
    end
  end
  
  def catalogs
    self.catalogs_collection.flatten.compact
  end
  
  def catalogs?
    self.catalogs.any?
  end
end
