class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  filter_parameter_logging :password, :password_confirm
  
  def home
    render :text => 'Homepage', :layout => 'application'
  end
end