class Admin::ProductLinesController < Admin::BaseController
  before_filter :retrieve_product_line, :only => [:show, :edit, :update, :destroy]
  
  def index
    @product_lines = Admin::ProductLine.list
  end

  def new
    @product_line = Admin::ProductLine.new
  end
  
  def create
    begin
      @product_line = Admin::ProductLine.new(params[:product_line])
      @product_line.save!
      flash_and_redirect(admin_product_lines_path, 'Product line has been created')
    rescue ActiveRecord::RecordInvalid
      render_new
    end
  end
  
  def update
    begin
      @product_line.update_attributes!(params[:product_line])
      flash_and_redirect(admin_product_lines_path, 'Product line has been updated')
    rescue ActiveRecord::RecordInvalid
      render_edit
    end
  end
  
  def destroy
    @product_line.destroy
    
    respond_to do |wants|
      wants.html do
        flash_and_redirect(admin_product_lines_path, 'Product line has been removed')
      end
      wants.json do
        render :json => {
          :id_to_remove => dom_id(@product_line)
        }
      end
    end
  end

private
  def retrieve_product_line
    begin
      @product_line = Admin::ProductLine.detail!(params[:id])
    rescue ActiveRecord::RecordNotFound
      render_404
    end
  end
  
  def retrieve_page_details
    @page_details ||= PageDetail.new(:title => 'Product Lines', :body_class => 'product-lines-home')
  end
end