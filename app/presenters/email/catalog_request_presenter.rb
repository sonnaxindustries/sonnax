class Email::CatalogRequestPresenter
  include ActionController::UrlWriter
  
  def initialize(entry)
    @object = entry
  end
  
  def entry
    @entry ||= @object
  end
  
  def subject
    '[Sonnax] Catalog Request'
  end
  
  def from
    'Sonnax Website <web@sonnax.com>'
  end
  
  def recipients
    ['nate@theklaibers.com', 'ep@sonnax.com', 'info@sonnax.com']
  end
  
  def sent_on
    Time.now
  end
  
  def body
    { 
      :catalog_request => self.entry
    }
  end
end
