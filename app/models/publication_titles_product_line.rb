class PublicationTitlesProductLine < ActiveRecord::Base
  belongs_to :publication, :class_name => 'PublicationTitle', :foreign_key => 'publication_title_id'
  belongs_to :product_line
end
