class Admin::BaseController < ApplicationController
  layout 'administration'
  before_filter :require_user
  
  def dashboard
    redirect_to(admin_product_lines_path, :status => 302)
  end
end