require 'notification'
require 'email/solenoid_program_presenter'

class SolenoidProgramObserver < ActiveRecord::Observer
  observe :solenoid_program
  
  def after_create(record)
    Notification.deliver_solenoid_program(Email::SolenoidProgramPresenter.new(record))
  end
end