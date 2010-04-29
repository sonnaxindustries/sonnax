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
            s_params = {
              :parent_id => category.id,
              :name => sc.subcategory,
              :description => sc.instructions
            }
            
            subcategory = self.new(s_params)
            subcategory.save!
            
            if sc.titles?
              sc.titles.each do |title|
                # NEED to figure out column mappings
                title_params = {
                  :title => title.title,
                  :description => title.author,
                  :volume_number => title.volume,
                  :published_at => title.date 
                }
                
                if title.pdf_file?
                  title_params.merge!(:pdf => title.pdf_file)
                end
                
                subcategory.titles.create!(title_params)
                puts "Title creates for the subcategory...."
                sleep(2)
              end
            end
          end
        end
      end
    end
  end
end