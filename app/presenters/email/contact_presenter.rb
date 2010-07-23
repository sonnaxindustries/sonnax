class Email::ContactPresenter
  include ActionController::UrlWriter
  
  def initialize(entry)
    @object = entry
  end
  
  def entry
    @entry ||= @object
  end
  
  def subject
    '[Sonnax] General Contact'
  end
  
  def from
    'Sonnax Website <web@sonnax.com>'
  end
  
  def recipients
    ['nate@theklaibers.com', 'ep@sonnax.com']
  end
  
  def sent_on
    Time.now
  end
  
  def body
    { 
      :contact => self.entry
    }
  end
end