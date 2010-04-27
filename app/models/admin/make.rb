class Admin::Make < Make
  named_scope :list, :order => 'id ASC'
    
  def validate
    self.errors.add(:name, 'There is already a make with that name') if self.existing_name?
  end
  
  def existing_name?
    self.name? && self.class.exists?(:name => self.name)
  end
  
  def before_create
    self.url_friendly = self.name.extend(Helper::String).to_url_friendly
  end
  
  def before_save
    self.key_name = self.name.extend(Helper::String).to_key_name
  end
end