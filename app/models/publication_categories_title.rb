class PublicationCategoriesTitle < ActiveRecord::Base
  belongs_to :title, :class_name => 'PublicationTitle', :foreign_key => 'publication_title_id'
  belongs_to :category, :class_name => 'PublicationCategory', :foreign_key => 'publication_category_id'
end
