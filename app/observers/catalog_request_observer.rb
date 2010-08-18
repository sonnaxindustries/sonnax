require 'notification'
require 'email/catalog_request_presenter'

class CatalogRequestObserver < ActiveRecord::Observer
  observe :catalog_request
  
  def after_create(record)
    Notification.deliver_catalog_request(Email::CatalogRequestPresenter.new(record))
  end
end