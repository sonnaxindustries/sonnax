require 'notification'
require 'email/order_presenter'

class OrderObserver < ActiveRecord::Observer
  observe :order
  
  def after_save(record)
    Notification.deliver_order(Email::OrderPresenter.new(record))
  end
end