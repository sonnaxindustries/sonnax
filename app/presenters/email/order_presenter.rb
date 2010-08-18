class Email::OrderPresenter
  include ActionController::UrlWriter
  
  def initialize(entry)
    @object = entry
  end
  
  def entry
    @entry ||= @object
  end
  
  def subject
    '[Sonnax] Quote Request'
  end
  
  def from
    'Sonnax Website <web@sonnax.com>'
  end
  
  def recipients
    ['nate@theklaibers.com']
    #['nate@theklaibers.com', 'ep@sonnax.com']
  end
  
  def sent_on
    Time.now
  end
  
  def body
    { 
      :order => self.entry
    }
  end
end