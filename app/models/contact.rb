class Contact < ActiveRecord::Base
  
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
end