class Import::Filesystem::Publication
  attr_accessor :publication

  class << self
    def import!
      publications = PublicationTitle.all
      publications.each do |p|
        klass = self.new(p.id)
        klass.import!
      end
    end
  end

  def initialize(publication_id)
    @publication = PublicationTitle.find(publication_id)
  end

  def import!
    if @publication.html_file? && !@publication.html_content?
      @publication.update_attributes(:html_content => @publication.html_file)
    end
  end
end
