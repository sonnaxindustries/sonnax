class PartAssetType < ActiveRecord::Base
  has_many :part_assets
  has_many :parts, :through => :part_assets
  
  validates_uniqueness_of :name
  
  def validate
    self.errors.add(:name, 'Please provide a name') unless self.name?
  end
  
  class << self
    def seeds
      ['Photo', 'Announcement', 'Instructions', 'Technical Bulletin', 'VB Fix'].each { |t| self.create(:name => t) }
    end
    
    def photo
      self.find(1)
    end
  end
  
  def same_name?(other)
    self.name.downcase == other.name.downcase
  end
  
  def generate_url_friendly!
    formatted_friendly = self.name.extend(Helper::String).to_url_friendly
    return formatted_friendly if !self.class.exists?(:url_friendly => formatted_friendly)
    n = 1
    n += 1 while self.class.exists?(:url_friendly => ("%s-%s" % [formatted_friendly, n.to_s]))
    return "%s-%s" % [formatted_friendly, n.to_s]
  end

  def before_create
    self.url_friendly = self.generate_url_friendly!
  end
end
