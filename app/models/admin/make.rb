class Admin::Make < Make
  has_many :units_makes, :dependent => :destroy, :class_name => 'Admin::UnitsMake'
  has_many :units, :through => :units_makes
  
  named_scope :list, :order => 'created_at DESC'
  
  class << self
    def options
      self.list
    end
  end
    
  def validate
    self.errors.add(:name, 'Please provide a name') unless self.name?
    self.errors.add(:name, 'There is already a make with that name') if self.existing_name?
  end
  
  def existing_name?
    self.new_record? && self.name? && self.class.exists?(:name => self.name)
  end
  
  def before_create
    self.url_friendly = self.name.extend(Helper::String).to_url_friendly
  end
  
  def before_save
    self.key_name = self.name.extend(Helper::String).to_key_name
  end
end