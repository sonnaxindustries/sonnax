class Admin::PartsController < Admin::BaseController
  def index
  end

  def new
  end

  def edit
  end
  
private
  def retrieve_page_details
    @page_details ||= PageDetail.new(:title => 'Parts', :body_class => 'parts-home')
  end
end
