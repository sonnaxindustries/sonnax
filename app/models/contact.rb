require 'ostruct'
class Contact < ActiveRecord::Base  
  DEPARTMENTS = [1, 2]
  
  def validate
    errors.add(:name, 'Please provide a name') unless self.name?
    errors.add(:email, 'Please provide an email') unless self.email?
    errors.add(:email, 'E-Mail address is invalid') unless self.valid_email_address?
    errors.add(:company, 'Please provide a company namae') unless self.company?
    errors.add(:phone_number, 'Please provide a phone number') unless self.phone_number?
    errors.add(:message, 'Please provide a message') unless self.message?
  end
  
  def valid_email_address?
    self.email? && Format::Email.valid?(self.email)
  end
  
  def email_settings
    settings = case self.department_id
    when 1
      { 
        :subject => '[Sonnax] General Contact',
        :recipients => ['nate@theklaibers.com', 'ep@sonnax.com', 'info@sonnax.com']
      }
    when 2
      {
        :subject => '[Sonnax] International Contact',
        :recipients => ['nate@theklaibers.com', 'ep@sonnax.com', 'internationalsalesteam@sonnax.com']
      }
    else
      { 
        :subject => '[Sonnax] General Contact',
        :recipients => ['nate@theklaibers.com', 'ep@sonnax.com', 'info@sonnax.com']
      }
    end
    @email_settings ||= OpenStruct.new(settings)
  end
  
  
end
