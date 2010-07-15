class Email::SolenoidProgramPresenter
  include ActionController::UrlWriter
  
  def initialize(entry)
    @object = entry
  end
  
  def entry
    @entry ||= @object
  end
  
  def subject
    '[Sonnax] Solenoid Core Purchase Program'
  end
  
  def from
    'Sonnax Website <web@sonnax.com>'
  end
  
  def recipients
    #'cores@sonnax.com'
    'nate@theklaibers.com'
  end
  
  def sent_on
    Time.now
  end
  
  def body
    { 
      :solenoid => self.entry
    }
  end
end