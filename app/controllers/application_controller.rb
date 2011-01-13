class ApplicationController < ActionController::Base
  include ExceptionNotification::Notifiable
  include ExceptionNotification::ConsiderLocal
  helper :all
  protect_from_forgery :secret => 'a19f3cb7872b8ea775172c6dc0c055beef263d71085ce962671a957aa7fa7a7df156f97f375eb9d87b85ccaf3c774db552f071b6f0e325e4d46e0b7bdebb367f'

  filter_parameter_logging :password, :password_confirmation
  
  before_filter :find_cart
  before_filter :retrieve_current_controller_info
  before_filter :retrieve_product_line_nav
  before_filter :retrieve_page_details
  helper_method :current_user_session, :current_user, :production?, :development?, :maintenance_mode?
  
  def development?
    'development' == RAILS_ENV
  end
  
  def production?
    'production' == RAILS_ENV
  end
  
  def retrieve_product_line_nav
    @product_lines_nav = ProductLine.list
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
  
  def retrieve_current_controller_info
    @current_controller = controller_name
    @current_action = action_name
  end
  
  def retrieve_page_details
    @page_details ||= PageDetail.new(:title => 'Home', :body_class => 'home')
  end
  
  def get_body_class
    @body_class ||= ''
  end
  
  def redirect_permanent(url)
    head :moved_permanently, :location => url
    return
  end
  
  def render_404
    render :template => 'pages/404.html.erb', :status => 404#, :layout => "inside"
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
  def find_cart 
    session[:cart] ||= Cart.new
  end
  
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
      flash_and_redirect(new_user_session_url, 'You must be logged in to access this page')
      return false
    end
  end

  def require_no_user
    if current_user
      store_location
      flash_and_redirect(account_url, 'You must be logged out to access this page')
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
