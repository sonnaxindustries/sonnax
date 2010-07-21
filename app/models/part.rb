class Part < ActiveRecord::Base
  belongs_to :part_type
  
  has_many :part_attributes, :dependent => :destroy
  
  def before_save
    self.part_type_id = PartType.default.id unless self.part_type_id?
  end
  
  def generate_url_friendly!
    formatted_friendly = self.part_number.extend(Helper::String).to_url_friendly
    return formatted_friendly if !self.class.exists?(:url_friendly => formatted_friendly)
    n = 1
    n += 1 while self.class.exists?(:url_friendly => ("%s-%s" % [formatted_friendly, n.to_s]))
    return "%s-%s" % [formatted_friendly, n.to_s]
  end

  def before_create
    self.url_friendly = self.generate_url_friendly!
  end
end
