class Email::ContactPresenter
  include ActionController::UrlWriter
  
  def initialize(entry)
    @object = entry
  end
  
  def entry
    @entry ||= @object
  end
  
  def subject
    self.entry.email_settings.subject
  end
  
  def from
    'Sonnax Website <web@sonnax.com>'
  end
  
  def recipients
    self.entry.email_settings.recipients
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
