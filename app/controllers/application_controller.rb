class ApplicationController < ActionController::Base
  helper :all
  protect_from_forgery

  filter_parameter_logging :password, :password_confirmation
  
  before_filter :get_current_controller_info
  helper_method :current_user_session, :current_user, :production?, :development?, :maintenance_mode?
  
  def development?
    'development' == RAILS_ENV
  end
  
  def production?
    'production' == RAILS_ENV
  end
  
  def force_www
    head :moved_permanently, :location => (self.with_www) if !/^www/.match(request.host) if self.production?
  end
  
  def with_www
    "%swww.%s%s" % [request.protocol, request.host_with_port, request.request_uri]
  end
  
  def flash_and_redirect(location, msg)
    flash[:notice] = if msg then msg else '' end
    redirect_to(location)
    return
  end
  
  def flash_and_redirect_back_or_default(location, msg)
    flash[:notice] = if msg then msg else '' end
    redirect_back_or_default(location)
    return
  end
  
  def get_current_controller_info
    @current_controller = controller_name
    @current_action = action_name
  end
  
  def get_body_class
    @body_class ||= ''
  end
  
  def redirect_permanent(url)
    head :moved_permanently, :location => url
    return
  end
  
  def render_404
    render :template => 'pages/404', :status => 404#, :layout => "inside"
  end
  
  def render_edit
    render :action => :edit
  end
  
  def render_new
    render :action => :new
  end
  
  def set_active_nav
    @active_nav = (controller_name || nil)
  end
  
  def set_active_subnav
    @active_subnav = (action_name || nil)
  end
  
private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end
  
  def require_user
    unless current_user
      store_location
      flash_and_redirect(new_admin_user_session_url, 'You must be logged in to access this page')
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash_and_redirect(admin_account_url, 'You must be logged out to access this page')
      return false
    end
  end

  def store_location
    session[:return_to] = request.request_uri
  end

  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end
end