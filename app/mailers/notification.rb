class Notification < ActionMailer::Base
    
  def solenoid_program(solenoid_program_presenter)
    subject     solenoid_program_presenter.subject
    recipients  solenoid_program_presenter.recipients
    from        solenoid_program_presenter.from
    sent_on     solenoid_program_presenter.sent_on
    body        solenoid_program_presenter.body
  end
  
  def catalog_request(catalog_request_presenter)
    subject     catalog_request_presenter.subject
    recipients  catalog_request_presenter.recipients
    from        catalog_request_presenter.from
    sent_on     catalog_request_presenter.sent_on
    body        catalog_request_presenter.body
  end
  
  def contact(contact_presenter)
    subject     contact_presenter.subject
    recipients  contact_presenter.recipients
    from        contact_presenter.from
    sent_on     contact_presenter.sent_on
    body        contact_presenter.body
  end
end