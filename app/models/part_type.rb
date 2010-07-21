class PartType < ActiveRecord::Base
  DEFAULT_TYPE_NAME = 'Uncategorized'
  
  has_many :parts, :dependent => :nullify
  
  validates_uniqueness_of :name
  
  def validate
    self.errors.add(:name, 'Please provide a name') unless self.name?
  end
  
  class << self
    def seeds
      ['Uncategorized'].each { |t| self.create(:name => t) }
    end
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
