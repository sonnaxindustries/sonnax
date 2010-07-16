require 'notification'
require 'email/contact_presenter'

class ContactObserver < ActiveRecord::Observer
  observe :contact
  
  def after_create(record)
    Notification.deliver_contact(Email::ContactPresenter.new(record))
  end
end