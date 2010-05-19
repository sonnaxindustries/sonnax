class PublicationTitlesAuthor < ActiveRecord::Base
  belongs_to :author
  belongs_to :publication_title
end
