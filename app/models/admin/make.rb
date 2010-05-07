class Admin::Make < Make
  named_scope :list, :order => 'created_at DESC'
    
  def validate
    self.errors.add(:name, 'Please provide a name') unless self.name?
    self.errors.add(:name, 'There is already a make with that name') if self.existing_name?
  end
  
  def existing_name?
    self.new_record? && self.name? && self.class.exists?(:name => self.name)
    #self.name? && (self.class.count(:conditions => ["LOWER(`name`) = ? AND (id IS NULL OR id <> ?)", self.name.downcase, self.id]) > 0)
  end
  
  def before_create
    self.url_friendly = self.name.extend(Helper::String).to_url_friendly
  end
  
  def before_save
    self.key_name = self.name.extend(Helper::String).to_key_name
  end
end