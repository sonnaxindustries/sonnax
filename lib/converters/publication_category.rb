class Converters::PublicationCategory < PublicationCategory
  class << self
    def run!
      Legacy::PublicationCategory.all.each do |m|
        params = {
          :name => m.category,
          :description => m.instructions
        }
        
        category = self.new(params)
        category.save!
        
        if m.publication_subcategories.any?
          m.publication_subcategories.each do |sc|
            params = {
              :parent_id => category.id,
              :name => sc.subcategory,
              :description => sc.instructions
            }
            self.create!(params)
          end
        end
      end
    end
  end
  
  def generate_url_friendly!
    formatted_friendly = self.name.extend(Helper::String).to_url_friendly
    return formatted_friendly if !self.class.exists?(:url_friendly => formatted_friendly)
    n = 1
    new_friendly = "%s-%s" % [formatted_friendly, n.to_s]
    n += 1 while self.class.exists?(:url_friendly => new_friendly)
    return "%s-%s" % [formatted_friendly, n.to_s]
  end
  
  def before_save
    self.url_friendly = self.generate_url_friendly!
  end
end